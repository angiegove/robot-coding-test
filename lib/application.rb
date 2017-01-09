require_relative 'robot'

class Application
  def initialize
    @robot = Robot.new
  end

  def start(commands)
    commands = commands.split("\s")
    command = commands.first
    positions = commands.last.split(",")
    if valid_commands.include? command
      case command
        when "PLACE"
            @robot.place(positions[0], positions[1], positions[2])
          when "MOVE"
            @robot.move if robot_placed
          when "LEFT"
            @robot.left if robot_placed
          when "RIGHT"
            @robot.right if robot_placed
          when "REPORT"
            @robot.report if robot_placed
          when "EXIT"
            exit_program
      end
    else
      puts "Invalid command please enter a valid command"
    end
  end

  def robot_placed
    if @robot.placed?
      true
    else
      raise RobotNotPlaced.new
    end
  end

  def exit_program
    puts "exiting program"
    exit(0)
  end

  private

  def valid_commands
    ['PLACE', 'MOVE', 'LEFT','RIGHT','REPORT', 'EXIT']
  end
end

class RobotNotPlaced < StandardError
end
