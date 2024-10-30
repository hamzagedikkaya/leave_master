# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  # Validations
  validates :name_surname, presence: { message: I18n.t("errors.messages.name_surname_blank") },
                           format: { with: /\A[a-zA-ZşŞıİçÇğĞöÖüÜ\s]+\z/, message: I18n.t("errors.messages.name_surname_invalid") }

  validates :gsm, presence: { message: I18n.t("errors.messages.gsm_invalid") },
                  numericality: { only_integer: true, message: I18n.t("errors.messages.gsm_invalid") }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :date_of_birth, presence: true
  validate :acceptable_image

  private

  def acceptable_image
    return unless profile_image.attached?

    errors.add(:profile_image, I18n.t("errors.messages.profile_image_too_large")) unless profile_image.byte_size <= 10.megabytes

    acceptable_types = ["image/jpg", "image/jpeg", "image/png"]
    return if acceptable_types.include?(profile_image.content_type)

    errors.add(:profile_image, I18n.t("errors.messages.profile_image_invalid_format"))
  end
end
