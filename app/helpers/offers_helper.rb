module OffersHelper
  def date_info offer
    out = t('offers.show.from') << ' ' << l(offer.from_date)
    out << ' ' << t('offers.show.to') << ' ' << l(offer.to_date) if offer.to_date
    out
  end

  def address_info offer
    if offer.street && offer.street != ''
      "#{offer.street}, #{offer.zip_code}, #{offer.district}"
    else
      "#{offer.zip_code}, #{offer.district}"
    end
  end
end
