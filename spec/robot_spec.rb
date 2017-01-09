require "rspec"
require_relative "../lib/robot.rb"

describe Robot do
  describe "#place" do
    context "specific coordinates and orientation given" do
      robot = Robot.new

      it "can be placed with specified position and orientation" do
        robot.place(1, 1, "WEST")
        expect(robot.x).to eq 1
        expect(robot.y).to eq 1
        expect(robot.orientation).to eq "WEST"
      end

      it "may not be placed outside of the table boundary" do
        expect { robot.place(1, 6, "WEST")}.to raise_error(OutOfBoundary)
        expect { robot.place(6, 1, "WEST")}.to raise_error(OutOfBoundary)
        expect { robot.place(-1, 1, "WEST")}.to raise_error(OutOfBoundary)
        expect { robot.place(1, -1, "WEST")}.to raise_error(OutOfBoundary)
      end
    end
  end

  describe "#move" do
    context "move one block within boundary" do
      context "move towards north" do
        it "moves one block facing North" do
          robot = Robot.new
          robot.place(0,0,"NORTH")
          robot.move
          expect(robot.x).to eq 0
          expect(robot.y).to eq 1
          expect(robot.orientation).to eq "NORTH"
        end
      end

      context "move towards South" do
        it "moves one block facing South" do
          robot = Robot.new
          robot.place(3, 3, "SOUTH")
          robot.move
          expect(robot.x).to eq 3
          expect(robot.y).to eq 2
          expect(robot.orientation).to eq "SOUTH"
        end
      end

      context "move towards West" do
        it "moves one block facing West" do
          robot = Robot.new
          robot.place(3, 3, "WEST")
          robot.move
          expect(robot.x).to eq 2
          expect(robot.y).to eq 3
          expect(robot.orientation).to eq "WEST"
        end
      end

      context "move towards East" do
        it "moves one block facing East" do
          robot = Robot.new
          robot.place(3, 3, "EAST")
          robot.move
          expect(robot.x).to eq 4
          expect(robot.y).to eq 3
          expect(robot.orientation).to eq "EAST"
        end
      end
    end

    context "move beyond the allowed boundry" do
      context "#move based on orientation North" do
        it "move one block facing south" do
          robot = Robot.new
          robot.place(0, 0, "SOUTH")
          expect {robot.move}.to raise_error(OutOfBoundary)
        end
      end

      context "#move based on orientation North" do
        it "move one block facing North" do
          robot = Robot.new
          robot.place(0, 5, "NORTH")
          expect {robot.move}.to raise_error(OutOfBoundary)
        end
      end

      context "#move based on orientation West" do
        it "move one block facing West" do
          robot = Robot.new
          robot.place(0, 0, "WEST")
          expect {robot.move}.to raise_error(OutOfBoundary)
        end
      end

      context "#move based on orientation East" do
        it "moves one block facing East" do
          robot = Robot.new
          robot.place(5, 0, "EAST")
          expect {robot.move}.to raise_error(OutOfBoundary)
        end
      end
    end

    context "move within allowed boundry" do
      context "#move towards South" do
        it "moves one block facing South" do
          robot = Robot.new
          robot.place(4, 3, "SOUTH")
          robot.move
          expect(robot.x).to eq 4
          expect(robot.y).to eq 2
        end
      end

      context "#move towards North" do
        it "moves one block facing North" do
          robot = Robot.new
          robot.place(4, 3, "NORTH")
          robot.move
          expect(robot.x).to eq 4
          expect(robot.y).to eq 4
        end
      end

      context "#move towards West" do
        it "moves one block facing West" do
          robot = Robot.new
          robot.place(4, 3, "WEST")
          robot.move
          expect(robot.x).to eq 3
          expect(robot.y).to eq 3
        end
      end

      context "#move towards East" do
        it "moves one block facing East" do
          robot = Robot.new
          robot.place(4, 3, "EAST")
          robot.move
          expect(robot.x).to eq 5
          expect(robot.y).to eq 3
        end
      end
    end
  end

  describe "#left" do
    it "when orientation is North, left changes it to West" do
      robot = Robot.new
      robot.place(4, 3, "NORTH")
      robot.left
      expect(robot.orientation).to eq "WEST"
    end

    it "when orientation is West, left changes it to South" do
      robot = Robot.new
      robot.place(4, 3, "WEST")
      robot.left
      expect(robot.orientation).to eq "SOUTH"
    end

    it "when orientation is South, left changes it to East" do
      robot = Robot.new
      robot.place(4, 3, "SOUTH")
      robot.left
      expect(robot.orientation).to eq "EAST"
    end

    it "when orientation is East, left changes it to North" do
      robot = Robot.new
      robot.place(4, 3, "EAST")
      robot.left
      expect(robot.orientation).to eq "NORTH"
    end
  end

  describe "#right" do
    it "when orientation is North, right changes it to East" do
      robot = Robot.new
      robot.place(4, 3, "NORTH")
      robot.right
      expect(robot.orientation).to eq "EAST"
    end

    it "when orientation is East, right changes it to South" do
      robot = Robot.new
      robot.place(4, 3, "EAST")
      robot.right
      expect(robot.orientation).to eq "SOUTH"
    end

    it "when orientation is South, right changes it to West" do
      robot = Robot.new
      robot.place(4, 3, "SOUTH")
      robot.right
      expect(robot.orientation).to eq "WEST"
    end

    it "when orientation is West, right changes it to North" do
      robot = Robot.new
      robot.place(4, 3, "WEST")
      robot.right
      expect(robot.orientation).to eq "NORTH"
    end
  end

  context "#report" do
    it "reports on the robots position" do
      robot = Robot.new
      robot.place(0, 0, "NORTH")
      robot.move
      expect(robot.report).to match("Your Robot is located at x: 0, y: 1, facing: NORTH")
    end
  end

  context "#place" do
    context "with valid coordinates" do
      it "places the robot on the given coordinates" do
        robot = Robot.new
        robot.place(2, 5, "NORTH")
        expect(robot.x).to eq 2
        expect(robot.y).to eq 5
        expect(robot.orientation).to eq "NORTH"
        expect(robot.placed).to eq true
      end
    end

    context "with invalid coordinates" do
      it "raises error" do
        robot = Robot.new
        expect {robot.place(2, 6, "NORTH")}.to raise_error(OutOfBoundary)
      end
    end
  end
end
