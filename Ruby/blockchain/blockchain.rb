# frozen_string_literal: true

require_relative "block"

class Blockchain
  attr_reader :chain

  def initialize
    @chain = []
    @hash_chain = {}
    add_block("Genesis Block") # Add genesis block for structural integrity
  end

  def add_block(data)
    raise "failed to append block: tampered chain" unless is_valid?

    index = @chain.length
    previous_hash = index.zero? ? "0" : latest_block.hash
    block = Block.new(index, Time.now.to_s, data, previous_hash)
    @chain << block
    @hash_chain[block.hash] = block
  end

  def tamper_block(index, new_data)
    block = @chain[index]
    return unless block

    block.instance_variable_set(:@data, new_data)
    block.instance_variable_set(:@hash, block.calculate_hash)
  end

  def latest_block
    @chain.last
  end

  def is_valid?
    @chain.each_cons(2) do |prev, curr|
      return false if curr.hash != curr.calculate_hash
      return false if curr.previous_hash != prev.hash
    end
    true
  end

  def [](hash_or_index)
    return get_block_by_index(hash_or_index) if hash_or_index.is_a?(Integer)
    return get_block_by_hash(hash_or_index) if hash_or_index.is_a?(String)

    raise "argument must be an integer for indexes or a valid string hash"
  end

  def get_block_by_index(index)
    @chain[index]
  end

  def get_block_by_hash(hash)
    @hash_chain[hash]
  end

  def to_s
    raise "chain is invalid, likely tampered with" unless is_valid?

    @chain.map(&:to_s).join("\n")
  end
end
