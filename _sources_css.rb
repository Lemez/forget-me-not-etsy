CSS = {
    "V and A" =>    {:product_css=>"article.product-thumb",
                    :price_css => "div.product-thumb__price",
                    :img_css => 'img',
                    :link_css =>'a',
                    :title_css => 'div.product-thumb__title',
                    :img_source => 'data-src',
                    :pagination_css=> 'a.pagination__next',
                    :desc_css=>nil,
                    :last_page_css=>'div.pagination__pages a'
            },
    "Kew"   =>   {:product_css=>'li.item',
                    :price_css => 'span.price',
                    :img_css => 'img',
                    :link_css =>'a.product-image',
                    :title_css => 'h2.product-name a',
                    :img_source => 'src',
                    :desc_css=>'div.std',
                    :pagination_css=> 'a.pagination__next',
                    :last_page_css=>'div.pagination__pages a'
            },

     "London Zoo"   =>   {:product_css=>'div.card-grid__item div.card',
                    :price_css => 'div.field-commerce-price',
                    :img_css => 'img',
                    :link_css =>'div.card__media a',
                    :title_css => 'h2.product-name a',
                    :img_source => 'src',
                    :desc_css=>nil,
                    :pagination_css=> 'li.pager-next'
            },
    "Tate"   =>   {:product_css=>'div.product-tile',
                    :price_css => 'div.product-pricing span',
                    :img_css => 'div.product-image a.thumb-link img',
                    :link_css =>'div.product-name a.name-link',
                    :title_css => 'div.product-name a.name-link span',
                    :img_source => 'src',
                    :desc_css=>nil,
                    :pagination_css=> 'ul.pagination-wrapper li.single-page',
                    :author_css=>'div.by-brand-wrapper span.brand-name'
            },      
    "Novalia"   =>   {:product_css=>'div.mk-product-holder',
                    :price_css => 'span.woocommerce-Price-amount',
                    :img_css => 'a img',
                    :link_css =>'a.woocommerce-LoopProduct-link',
                    :title_css => 'a img',
                    :desc_css=>nil,
                    :img_source => 'data-mk-image-src-set',
                    :pagination_css=> 'div.mk-woocommerce-result-count'
            },
     "Pops And Ozzy"   =>   {:product_css=>'div.product-index',
                    :price_css => 'data-price',
                    :img_css => 'a img',
                    :link_css =>'a',
                    :title_css => 'data-alpha',
                    :img_source => 'src',
                    :desc_css=> nil,
                    :pagination_css=> 'div#pagination a'
            },
     "Ethical Kidz" =>   {:product_css=>'div.productpreview',
                    :price_css => 'span.OurPrice b',
                    :img_css => 'div.image a img',
                    :link_css =>nil,
                    :desc_css=>'p.description',
                    :title_css => 'h3 a',
                    :img_source =>'src' ,
                    :pagination_css=> nil
            },
     "Pushkin Press" =>   {:product_css=>'a.taxpagebook',
                    :price_css => 'span.woocommerce-Price-amount',
                    :img_css => 'div.taxpage img',
                    :link_css =>nil,
                    :desc_css=>'div.woocommerce-product-details__short-description p',
                    :title_css => 'div.taxpage img',
                    :secondary_title_css => 'h1.product_title',
                    :img_source =>'src' ,
                    :pagination_css=> nil
            }


}