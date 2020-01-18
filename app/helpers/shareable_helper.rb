module ShareableHelper
    def is_shared(resource)
        return resource.user.id != current_user.id
    end         
end