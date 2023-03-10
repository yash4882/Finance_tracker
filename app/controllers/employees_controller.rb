class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
    @employees.each do|emp|
      id = emp.id
      DeleteJob.set(wait: 24.hours).perform_later(id)
    end
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.create(params_emp)
    if @employee.save
      # WelcomeMailer.welcome_email.deliver_now
      EmailJob.set(wait: 15.seconds).perform_later(@employee)
      redirect_to @employee
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def count
    @employee = Employee.find(params[:id])
    count = @employee.entry
    @employee.update(entry: count + 1)
    redirect_to employees_path
  end

  def remove
    @employee = Employee.find(params[:id])
    count = @employee.entry
    if count > 0
      @employee.update(entry: count - 1)
    end
    redirect_to employees_path
  end


  def update
    @employee = Employee.find(params[:id])

    if @employee.update(params_emp)
      redirect_to @employee
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path, status: :see_other
  end

  private
  def params_emp
    params.require(:employee).permit(:name, :entry, :time)
    
  end
end
