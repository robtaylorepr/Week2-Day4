
require 'tty'

prompt = TTY::Prompt.new

begin
   s = "Do you want to play a game?"
   reply = prompt.ask(s)
end until reply=='n'
