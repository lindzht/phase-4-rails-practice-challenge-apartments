class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry


    def index
        render json: Tenant.all, status: :ok
    end

    def show
        tenant = find_tenant
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = find_tenant
        tenant.update(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        render json: {}, status: :ok
    end




    private

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def invalid_entry(invalid)
        render json: {error: ErrorMessageSerializer.messages(invalid.record.errors)}, status: :unprocessable_entity
    end
    
    


end
