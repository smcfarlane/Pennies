require_relative 'spec_helper'
require_relative 'fake_ws'
require_relative '../../src/server'
require 'byebug'

RSpec.describe 'StartGame initegration' do
  player1 = {handler: 'add-player', player: {hand: [], id: "f66d4f70-f815-0132-ec77-245e60cb8e15", name: "john", pennies: 10, position: 0, room: "", score: 0}}
  player2 = {handler: 'add-player', player: {hand: [], id: "f66d4f70-f815-0132-ec77-245e60cb8e16", name: "jane", pennies: 10, position: 0, room: "", score: 0}}
  room = {handler: 'create_room', room_name: 'room 1', player: {hand: [], id: "f66d4f70-f815-0132-ec77-245e60cb8e15", name: "john", pennies: 10, position: 0, room: "", score: 0}}
  app =  Application::GameBackend.new ''
  p1 = app.handle_call(nil, FakeWS.new(player1))
  p2 = app.handle_call(nil, FakeWS.new(player2))
  r = app.handle_call(nil, FakeWS.new(room))
  join_room = {handler: 'join_room', room_id: r['room']['id'], player: {hand: [], id: "f66d4f70-f815-0132-ec77-245e60cb8e16", name: "jane", pennies: 10, position: 0, room: "", score: 0}}
  jr = app.handle_call(nil, FakeWS.new(join_room))

  it 'creates a new game' do
    message = {handler: 'start_game', room_id: r['room']['id']}
    g = app.handle_call(nil, FakeWS.new(message))
    expect(g['game']).to be_truthy
  end
end
