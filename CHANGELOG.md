# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.1.0] - 2017-
### [Added]
- Janus Instance management
- Initializer for rake task

## [2.0.0] - 2017-03-29
### [Added]
- Admin feature
- Complete documentation with example
- Customize response (standard/admin)
- Filter in log for sensitive data (expection debug mode message)
- Spec for RubyRabbitmqJanus::Tools::Type
- Add request for testing type
- Complete default plugins
- Add type convert_array
- add type "<transaction>"
- Spec for RubyRabbitmqJanus::Messages
- Spec for RubyRabbitmqJanus::Rabbit

### [Changed]
- Session ID management
- Type converting
- Delete many method for simplify gem usage

### [Deleted]
- Delete unless method

## [1.2.9] - 2017-02-14
### [Fixed]
- Keepalive deadlock, fixed using semaphore in place of condition variable

## [1.2.8] - 2017-01-27
### [Fixed]
- Session keepalive cut

### [Changed]
- Add comment
- Cleaning code in processus
- Optimize session management

## [1.2.7] - 2017-01-24
### [Fixed]
- Fix test with travis
- Fix sdp sending

## [1.2.6] - 2017-01-23
### [Fixed]
- Send request for candidate 'peer::trickle', (For ONE candiadte)
- Send request for candidates 'peer::trickles' (For manys candidates in array)

## [1.2.5] - 2017-01-19
### [Fixed]
- Delete unless variables @transaction

## [1.2.4] - 2017-01-18
### [Changed]
- Change name method send/publish messages
- Deploy just for master branch pushing

### [Added]
- Complete info in README
- Add number session to log when sending a request keepalive
- Complete tests
- Add Pre Release with travis

### [Fixed]
- Travis notification and deploy
- Name execption in init class

## [1.2.3] - 2016-12-20
### [Changed]
- Fix number session used

## [1.2.2] - 2016-12-16
### [Added]
- Errors messages

### [Changed]
- Fix handle manipulation in transaction
- Fix session keepalive thread

### [Deleted]
- Remove file in documentations

## [1.2.1] - 2016-12-16
### [Changed]
- Fix handle reading if is sending to request
- Delete branch repo for deploy action in travis

## [1.2.0] - 2016-12-15
### [Added]
- dockerignore for travis
- Add badge docs
- Add request/spec for peer (trickle, offer, answer)

### [Changed]
- Complete docs
- Fix building for travis and add test for admin request
- Build with travis just for master branche
- Update Config for reading plugin in config file
- Refractoring transaction
- Update information for default configuration/requests
- Update SPEC
- Update configuration to reek
- Update configuration yard doc
- Interpret RRJ configuration file
- Update configuration file. Move queue elements, delete thread options

### [Deleted]
- Delete class Env

## [1.1.12] - 2016-12-07
### [Changed]
- Delete analisys response, return all message (include error)

### [Added]
- Info to log information session created with janus

## [1.1.11] - 2016-12-05
### [Changed]
- Fix admin request handle info

## [1.1.10] - 2016-12-02
### [Changed]
- Update metrics

## [1.1.9] - 2016-11-30
### [Changed]
- Refractoring initializer with create class in 'app/ruby_rabbitmq_janus'
- Initialize RRJ variables all the time for used in rake actions
- Update listener for each message in standard queue is treatment

### [Added]
- Add generetor install
- Rakefile and configure Travis services
- Deploy with travis-ci
- Control travis.yml is correct

## [1.1.8] - 2016-11-29
### [Changed]
- Return handle created with start_handle method
- Complete info in README.md
- Change metrics length

### [Deleted]
- Delete a test script `listen.rb`

## [1.1.7] - 2016-11-28
### [Changed]
- Use handle if is given in arguments for handle_message_simple
- Update default initializer with comments and fix rake execution

## [1.1.6] - 2016-11-24
### [Added]
- Add this changelog file

### [Changed]
- Update in config file log level field reading upcase or downcase is acceptable
