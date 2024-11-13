# frozen_string_literal: true

class LeaveType < ApplicationRecord
  has_many :leave_requests, dependent: :nullify
end
