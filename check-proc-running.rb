#!/usr/bin/env ruby
#
#   check-proc-running
#
# DESCRIPTION:
#   It is checked whether or not to start by specifying the name of the process.
#  
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   
#
# USAGE:
#   #YELLOW
#
# NOTES:
#
# LICENSE:
#   Copyright 2015 Tsubasa Hirota <tsubasa11@marble.ocn.ne.jp>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'rubygems' if RUBY_VERSION < '1.9.0'
require "sensu-plugin/check/cli"

class CheckProcRun < Sensu::Plugin::Check::CLI

  option :proc_name,
    short:       "-p process_name",
    long:        "--proc process_name",
    description: "Define the Process Name(Require)"

  def run
    procs = `ps aux | grep -v check-proc-running`
    running = false
    procs.each_line do |proc|
      running = true if proc.include?("#{config[:proc_name]}")
    end
    if running
      ok "#{config[:proc_name]} running."
    else
      critical "#{config[:proc_name]} down."
    end
  end
end
