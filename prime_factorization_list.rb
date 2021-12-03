#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
#-----------------------------------------------------------------------------
#
#
#
#	2021-12-03
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
#
#-----------------------------------------------------------------------------
require "prime"

# 素因数分解リストを作成する
def create_prime_factorization_list_txt
  filename_out = "prime_factorization_list.txt"

  File.open(filename_out, "w") do |fp|
    (2..10000).each do |n|
      prime_factors = Prime.prime_division(n)

      prime_factors_str = prime_factors.map { |prime, exp|
        "[#{prime}^#{exp}]"
      }.join(" * ")
      fp.puts(%Q!#{"%5d : %s" % [n, prime_factors_str]}!)
    end
  end
end

# 最小公倍数リストを作る
# (2..n) までの最小公倍数
def create_lcm_list_txt( max_n = 10000, filename_out = "lcm_list.txt" )
  last_lcm = 1
  # last_lcm の素因数と指数
  prime_factors_list = Hash.new { |h, k| h[k] = 0 }

  File.open(filename_out, "w") do |fp|
    (2..max_n).each do |n|
      # 素因数分解
      prime_factors = Prime.prime_division(n)

      prime_factors.each do |prime, exp|
        if prime_factors_list.include?(prime)
          if prime_factors_list[prime] < exp
            last_lcm *= prime ** (exp - prime_factors_list[prime])
            prime_factors_list[prime] = exp
          end
        else
          prime_factors_list[prime] = exp
          last_lcm *= prime ** exp
        end
      end

      fp.puts(%Q!#{"%5d : %s" % [n, last_lcm]}!)
    end
  end
end

# 実行部
def main
  create_lcm_list_txt( 10000 )
end

main
