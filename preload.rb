# frozen_string_literal: true

# Load Rails environment before forking workers
# This improves memory efficiency via Copy-On-Write
require_relative "config/environment"
