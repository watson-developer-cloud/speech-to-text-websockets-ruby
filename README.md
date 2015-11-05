# Speech To Text Ruby Client
Ruby client that interacts with the [IBM Watson Speech to Text service](http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/speech-to-text.html) through its WebSockets interface
#Installation
[Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
#How to Use
You will need to fill in the vacant username and password entries in the example.rb file before you can run it. You will specifically need a username and password for the speech-to-text service. Please note that service credentials are different than Bluemix account credentials.

To get service credentials, follow these steps:
 1. Log in to Bluemix at https://bluemix.net. If you don't have an account, sign up [here](https://console.ng.bluemix.net/registration/) for a 30-day free trial.

 2. Create an instance of the service:
     1. In the Bluemix **Catalog**, scroll down to Services and select the Speech To Text service from **Watson**.
     2. Under **Add Service**, type a unique name for the service instance in the Service name field. For example, type `my-service-name`. Leave the default values for the other options.
     3. Click **Create**.

 3. Copy your credentials:
     1. On the left side of the page, click **Service Credentials** to view your service credentials.
     2. Copy `username` and `password` from these service credentials and paste them into the example.rb file.
     
 4. Run the example.rb file
 
#Dependencies
For this client to work properly, some additional dependencies need to be installed. First, make sure to install the Ruby Package Managment Framework, called Ruby Gems, from [here] (https://rubygems.org/pages/download). Afterwards, you need to install the following dependencies:
 1. websocket-client-simple
 2. eventmachine
 3. activesupport

For help on how to install a dependency, called a 'gem' in ruby, follow [this link] (http://guides.rubygems.org/rubygems-basics/#installing-gems).
