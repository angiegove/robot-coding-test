require "rspec"
require_relative "../lib/application.rb"

describe Application do
  describe '#start' do
    context 'recieves PLACE command with valid coordinates and orientation' do
      it "places the robot" do
        application = Application.new
        expect(application.start("PLACE 2,3,NORTH")).to match "ROBOT has been placed at x: 2, y: 3, facing: NORTH"
      end
    end

    context 'recieves PLACE command with invalid coordinates and orientation' do
      it "raise_error" do
        application = Application.new
        expect {application.start("PLACE 5,8,NORTH")}.to raise_error(OutOfBoundary)
      end
    end

    context 'when command id given once robot is placed' do
      it "execute command" do
        application = Application.new
        application.start("PLACE 2,3,NORTH")
        application.start("MOVE")
        application.start("LEFT")
        expect(application.start("REPORT")).to match "Your Robot is located at x: 2, y: 4, facing: WEST"
      end
    end

    context 'when given a command before robot is placed' do
      it "raise_error" do
        application = Application.new
        expect {application.start("MOVE")}.to raise_error(RobotNotPlaced)
      end
    end
  end

  describe "#exit_program" do
    it "returns exit command" do
      application = Application.new
      application.start("EXIT")
      expect(output).to raise_error(SystemExit)
    end
  end
end
