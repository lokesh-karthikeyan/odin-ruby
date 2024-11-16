# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'fileutils'

require_relative 'lib/event_manager'
