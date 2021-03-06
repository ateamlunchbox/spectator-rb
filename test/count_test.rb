# frozen_string_literal: true

require 'test_helper'
require 'spectator/measure'

class CounterTest < Minitest::Test
  def setup
    id = Spectator::MeterId.new('counter')
    @cnt = Spectator::Counter.new(id)
  end

  def test_increment
    assert_equal(0, @cnt.count)
    @cnt.increment(1000)
    assert_equal(1000, @cnt.count)
    @cnt.increment
    assert_equal(1001, @cnt.count)
  end

  def test_measure
    @cnt.increment(1000)
    ms = @cnt.measure
    assert_equal(1, ms.size)

    base = Spectator::MeterId.new('counter')
    count = Spectator::Measure.new(base.with_stat('count'), 1000)

    expected = [count]
    assert_equal(expected, ms)

    ms = @cnt.measure
    assert_empty(ms)
  end

  def test_to_s
    expected = 'Counter{id=MeterId{name=counter, tags={}}, count=0}'
    assert_equal(expected, @cnt.to_s)
  end
end
