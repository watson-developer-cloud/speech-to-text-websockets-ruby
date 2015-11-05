#ruby_example.rb
#!/usr/bin/env ru   by

#
# @author: Daniel Bolanos, 2015
#

require 'eventmachine'
require 'rubygems'
require 'websocket-client-simple'
require 'json'
require 'uri'
require 'net/http'

params = {
     'action'             => "start",
     'content-type'       => "audio/wav", 
     'continuous'         => true,
     'inactivity_timeout' => -1,
     'interim_results'    => true
}
class File
   def read_chunk(chunk_size=2000)
       yield read(chunk_size) until eof?
   end
end

token = ''
uri = URI.parse("https://stream.watsonplatform.net/authorization/api/v1/token?url=https://stream.watsonplatform.net/speech-to-text/api")
Net::HTTP.start(uri.host, uri.port,:use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new(uri)
    request.basic_auth 'insert username', 'insert password'
    token = http.request(request)
end

watson_url = "wss://stream.watsonplatform.net/speech-to-text/api/v1/recognize?watson-token=#{token.body}"
file_url = "./0001.wav"#replace this with the file you want to read

init_message = params.to_json
ws = ''
 # run websocket in an EventMachine
EM.run {
  ws = WebSocket::Client::Simple.connect watson_url
   file_sent = false
 
   ws.on :message do |event|
      puts "message: #{event.data}"
      data = JSON.parse(event.data)
      if data['state'] && data['state'] == 'listening'
         if file_sent == true          
            EM::stop_event_loop
         else
            file_sent = true
            open(file_url, 'rb') do |file|
               file.read_chunk {|chunk| ws.send(chunk, type: :binary) }
            end
            ws.send("", type: :binary)
         end      
      end
    
   end
 
   ws.on :open do
     puts "-- websocket open"
     puts             init_message
     ws.send(init_message)
   end

   ws.on :close do |e|
     puts "-- websocket close #{if e!=nil then (e) end}"
     exit 1
   end

   ws.on :error do |e|
     puts "-- error (#{e.inspect})"
   end
}
ws.close
