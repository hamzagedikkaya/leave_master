# frozen_string_literal: true

class LeaveRequest < ApplicationRecord
  belongs_to :leave_type
  belongs_to :user

  enum :status, { pending: 0, approved: 1, rejected: 2 }
end
