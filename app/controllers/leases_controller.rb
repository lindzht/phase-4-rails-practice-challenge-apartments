class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry


    def index
        render json: Lease.all, status: :ok
    end

    def show
        lease = find_lease
        render json: lease, status: :ok
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    # def update
    #     lease = find_lease
    #     lease.update(lease_params)
    #     render json: lease, status: :ok
    # end

    def destroy
        lease = find_lease
        lease.destroy
        render json: {}, status: :ok
    end




    private

    def find_lease
        Lease.find(params[:id])
    end

    def lease_params
        params.permit(:rent)
    end

    def not_found
        render json: {error: "Lease not found"}, status: :not_found
    end

    def invalid_entry(invalid)
        render json: {error: ErrorMessageSerializer.messages(invalid.record.errors)}, status: :unprocessable_entity
    end



end
