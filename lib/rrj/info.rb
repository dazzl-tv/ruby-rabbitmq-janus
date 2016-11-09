# frozen_string_literal: true
# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# Define constant to gem.
module RubyRabbitmqJanus
  # Define version to gem
  VERSION = '1.0.2'

  # Define a summary description to gem
  SUMMARY = 'Ruby RabbitMQ Janus'

  # Define a long description to gem
  DESCRIPTION = 'This gem is used to communicate to a server Janus through RabbitMQ '\
    'software (Message-oriented middleware). It waiting a messages to Rails API who ' \
    'send to RabbitMQ server in a queue for janus server. Janus processes a message ' \
    'and send to RabbitMQ server in a queue for gem. Once the received message is ' \
    'decoded and returned through the Rails API.'

  # Define homepage
  HOMEPAGE = 'https://github.com/dazzl-tv/ruby-rabbitmq-janus'

  # Define a post install message
  POST_INSTALL = \
    "# ====================================================== #\n" \
    "# Thanks for installing RRJ !                            #\n" \
    "# #{HOMEPAGE}.       #\n" \
    "# ;;;;;;;;;;;:.                                          #\n" \
    "# ;;;;;;;;;;;;;;;;;;                                     #\n" \
    "# ;;;;;;;;;;;:;;;;;;;;                                   #\n" \
    "# ;;;;;;;;;;` ;;;;;;;;                                   #\n" \
    "# ;;;;;;;;;  :;;;;;;;;.                                  #\n" \
    "# ;;;;;;;;   :::::;;;;;                                  #\n" \
    "# ;;;;;;,       ,;;;;;;                                  #\n" \
    "# ;;;;;        ;;;;;;;;                                  #\n" \
    "# ;;;;;;;;;   ;;;;;;;;,                                  #\n" \
    "# ;;;;;;;;; `;;;;;;;;;     A    ZZZZZZZ ZZZZZZZ LL       #\n" \
    "# ;;;;;;;;.:;;;;;;;;;;    A A      ZZZ     ZZZ  LL       #\n" \
    "# ;;;;;;;;;;;;;;;;;      AAAAA   ZZ      ZZ     LL       #\n" \
    "# ;;;;;;;;;;;;;,        A     A ZZZZZZZ ZZZZZZZ LLLLLLL  #\n" \
    '# ====================================================== #'
end