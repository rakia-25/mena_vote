class GenericsController < AuthController
  before_action :set_resource, only: [:edit, :show, :update, :print, :destroy]

  def index
    authorize resource_class
    plural_resource_name = "@#{resource_name.pluralize}"
    @pagy, resources = pagy(resource_class.search(filter_params))
    instance_variable_set(plural_resource_name, resources.decorate)
  end
  
  def show
    authorize get_resource
  end

  def new
    authorize resource_class, :create?
    instance_variable_set("@#{resource_name}", resource_class.new)
  end

  def create
    authorize resource_class
    set_resource(resource_class.new(resource_params))
    yield if block_given?
    if get_resource.save
      redirect_to send("#{resource_name.pluralize}_path"), notice: "Action exécutée avec success"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if get_resource.update(resource_params)
      redirect_to send("#{resource_name.pluralize}_path"), notice: "Action exécutée avec success"
    else
      render :edit
    end
  end

  def destroy
    get_resource.destroy
    redirect_to send("#{resource_name.pluralize}_path"), notice: "Action exécutée avec success"
  end

  private

    def get_resource
      instance_variable_get("@#{resource_name}")
    end

    def filter_params
      {}
    end

    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    def resource_name
      @resource_name ||= self.controller_name.singularize
    end

    def resource_params
      @resource_params ||= self.send("#{resource_name}_params")
    end

    def set_resource(resource = nil)
      resource ||= resource_class.find(params[:id])
      instance_variable_set("@#{resource_name}", resource.decorate)
    end
end
