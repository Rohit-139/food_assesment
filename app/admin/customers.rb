  ActiveAdmin.register Customer do

    # See permitted parameters documentation:
    # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
    #
    # Uncomment all parameters which should be permitted for assignment
    #
    # action :all
    permit_params :email, :name, :type, :password, :password_confirmation

    index do
      selectable_column
      id_column
      column :name
      column :email
      column :created_at
      column :type
      actions 
    end

    controller do
      def destroy
        customer = Customer.find(params[:id])
        customer.destroy!
        redirect_to collection_path, notice: "Record permanently deleted!"
      end
    end



     

    form do |f|
      f.inputs "Customer details" do
        f.input :name
        f.input :email
        f.input :password
        f.input :password_confirmation

        f.input :type, value: "Customer"

      end
      f.actions
    end
  end
