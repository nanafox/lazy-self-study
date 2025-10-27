# frozen_string_literal: true

require "digest"

class Block
  attr_reader :index, :timestamp, :data, :previous_hash, :hash

  def initialize(index, timestamp, data, previous_hash)
    @index = index
    @timestamp = timestamp
    @data = data
    @previous_hash = previous_hash
    @hash = calculate_hash
  end

  def to_s
    <<~BLOCK
      ── Block ##{index} ─────────────────────────────
      Timestamp     : #{timestamp}
      Data          : #{data}
      Previous Hash : #{previous_hash}
      Hash          : #{hash}
      ────────────────────────────────────────────────
    BLOCK
  end

  def calculate_hash
    Digest::SHA256.hexdigest(@index.to_s + @timestamp.to_s + @data + @previous_hash)
  end
end
