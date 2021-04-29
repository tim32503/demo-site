import Rails from "@rails/ujs" // 非侵入式JS
import Turbolinks from "turbolinks" // 非同步 ajax 方式處理網頁呈現
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'icon/fontawesome'
import 'frontend'
import 'styles'
import "controllers"
