class Main
  register Sinatra::AssetPack
  assets do
    js :application, %w[
      /js/vendor/*.js
      /js/lib/*.js
      /js/app/*.js
    ]

    css :main, %w[
      /css/style.css
    ]
  end
end
