# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates
  validates :name_surname, presence: { message: I18n.t("errors.messages.name_surname_blank") },
                           format: { with: /\A[a-zA-ZşŞıİçÇğĞöÖüÜ\s]+\z/, message: I18n.t("errors.messages.name_surname_invalid") }

  validates :gsm, presence: { message: I18n.t("errors.messages.gsm_invalid") },
                  numericality: { only_integer: true, message: I18n.t("errors.messages.gsm_invalid") }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
end
