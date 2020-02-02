require_relative '../lib/connect4.rb'

describe "Connect4" do
  describe "#evaluate_game" do
    it "Returns an icon if there are four-in-a-row of same icon horizontally" do
      game = Game.new
      game.update_hash("s", :a1, :a2, :a3)
      game.update_hash("b", :a4, :a5, :a6, :a7)
      expect(game.evaluate_game).to eql("b")
    end
    it "Returns an icon if there are four-in-a-row of same icon vertically" do
      game = Game.new
      game.update_hash("s", :a1, :b1, :a3)
      game.update_hash("b", :a4, :b4, :c4, :d4)
      expect(game.evaluate_game).to eql("b")
    end
    it "Returns an icon if there are four-in-a-row of same icon diagonally-left" do
      game = Game.new
      game.update_hash("s", :a1, :b1, :a3)
      game.update_hash("b", :a4, :b3, :c2, :d1)
      expect(game.evaluate_game).to eql("b")
    end
    it "Returns an icon if there are four-in-a-row of same icon diagonally-right" do
      game = Game.new
      game.update_hash("b", :a4, :b1, :a3)
      game.update_hash("s", :a1, :b2, :c3, :d4)
      expect(game.evaluate_game).to eql("s")
    end
    it "Returns false if there are no four-in-a-row of same icon" do
      game = Game.new
      game.update_hash("s", :a1, :a2, :a3, :a5)
      game.update_hash("b", :a4, :a6, :a7, :b2)
      expect(game.evaluate_game).to eql(false)
    end
    it "Returns tie if there are no four-in-a-row of same icon and board is full" do
      game = Game.new
      game.update_hash("s", :a1, :a2, :a5, :a6, :b3, :b4, :b7, :c1, :c2, :c5, :c6, :d3, :d4, :d7, :e1, :e2, :e5, :e6, :f3, :f4, :f7)
      game.update_hash("b", :a3, :a4, :a7, :b1, :b2, :b5, :b6, :c3, :c4, :c7, :d1, :d2, :d5, :d6, :e3, :e4, :e7, :f1, :f2, :f5, :f6)
      expect(game.evaluate_game).to eql('tie')
    end
  end
  describe "#token_drop" do
    it "Places a token in correct row if no rows of that column are occupied" do
      game = Game.new
      game.update_hash("b", :a1, :a2, :a3)
      game.update_hash("s", :b1, :b2, :b3)
      expect(game.token_drop("b", "4")).to eql(:a4)
    end
    it "Places a token in correct row if bottom row of that column is occupied" do
      game = Game.new
      game.update_hash("b", :a1, :a2, :a3)
      game.update_hash("s", :b1, :b2, :b3)
      expect(game.token_drop("b", "3")).to eql(:c3)
    end
    it "Returns false if all rows fo that column are occupied" do
      game = Game.new
      game.update_hash("b", :a1, :c1, :e1)
      game.update_hash("s", :b1, :d1, :f1)
      expect(game.token_drop("b", "1")).to eql(false)
    end
  end
end