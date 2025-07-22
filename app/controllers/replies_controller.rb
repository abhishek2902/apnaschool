class RepliesController < ApplicationController

    def new
        @grievance = Grievance.find(params[:grievance_id])  # ✅ Find grievance first
        @reply = @grievance.replies.build  # ✅ Associate reply with grievance
    end

    def create
        @grievance = Grievance.find(params[:grievance_id])  # ✅ Find the grievance
        @reply = @grievance.replies.build(reply_params)  # ✅ Associate reply with grievance

        if @reply.save
            redirect_to grievances_path, notice: "Reply submitted successfully."
        else
            render :new
        end
    end

    def destroy
        @reply= Reply.find(params[:id])
        @reply.destroy
        redirect_to grievances_path
    end

    private
    def reply_params
        params.require(:reply).permit(:name, :text)
    end
end