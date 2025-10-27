require_relative "blockchain"

# Example usage
my_chain = Blockchain.new
my_chain.add_block("First transaction")
my_chain.add_block("Second transaction")

puts "Before tampering: #{my_chain.is_valid?}"  # => true

puts my_chain

# Tamper with block 1
my_chain.tamper_block(1, "Hacked transaction")

puts "\n\nAfter tampering: #{my_chain.is_valid?}"   # => false
puts my_chain
