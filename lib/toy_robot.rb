require_relative 'application'

puts "Welcome to toy robot please enter one of the following valid commands:
    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT
    EXIT\n"

command = $stdin.gets
application = Application.new

while command
  begin
    output = application.start(command)
    puts output if output
    command = $stdin.gets
  rescue => exception
    puts exception
    command = $stdin.gets
  end
end
