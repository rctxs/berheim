ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard.title') }

  content title: proc{ I18n.t('active_admin.dashboard.title') } do
    columns do
      column do
        panel I18n.t('active_admin.dashboard.not_unlocked') do
          h6 I18n.t('activerecord.models.offer.other')
          table_for(Offer.all) do
            column :title
            column :description
            column I18n.t('active_admin.actions.title') do |offer|
              link_to(I18n.t('active_admin.actions.show'), offer) + ' ' +
              link_to(offer.blocked ? 'Freischalten' : 'Sperren', offer.blocked ? unblock_admin_offer_path(offer) : block_admin_offer_path(offer), method: :put) + ' ' +
              link_to(I18n.t('active_admin.actions.show_in_admin_panel'), admin_offer_path(offer))
            end
          end
          h6 I18n.t('activerecord.models.request.other')
          table_for(Request.all) do
            column :title
            column :description
            column I18n.t('active_admin.actions.title') do |request|
              link_to(I18n.t('active_admin.actions.show'), request) + ' ' +
              link_to(request.blocked ? 'Freischalten' : 'Sperren', request.blocked ? unblock_admin_request_path(request) : block_admin_request_path(request), method: :put) + ' ' +
              link_to(I18n.t('active_admin.actions.show_in_admin_panel'), admin_request_path(request))
            end
          end
        end
      end
    end
  end
end
