require_relative '../config/environment'

new_cli = CLI.new


new_customer = new_cli.greet_and_get_customer
new_cli.run(new_customer, new_cli)



