// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import Lightbox from '@stimulus-components/lightbox'
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)

application.register('lightbox', Lightbox)
