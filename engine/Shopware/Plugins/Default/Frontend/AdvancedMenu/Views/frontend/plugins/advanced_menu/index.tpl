{block name="frontend_index_navigation_categories_top_include" append}
    {function name="categories_top" level=0}

        {$columnIndex = 0}
        {$menuSizePercentage = 100 - (25 * $columnAmount * intval($hasTeaser))}
        {$columnCount = 4 - ($columnAmount * intval($hasTeaser))}

        <ul class="menu--list menu--level-{$level} columns--{$columnCount}"{if $level === 0} style="width: {$menuSizePercentage}%;{/if}">
            {block name="frontend_plugins_advanced_menu_list"}
                {foreach $categories as $category}
                    {if $category.hidetop}
                        {continue}
                    {/if}

                    <li class="menu--list-item item--level-{$level}"{if $level === 0} style="width: 100%"{/if}>
                        {block name="frontend_plugins_advanced_menu_list_item"}
                            <a href="{$category.link}" class="menu--list-item-link" title="{$category.name}">{$category.name}</a>

                            {if $category.sub}
                                {call name=categories_top categories=$category.sub level=$level+1}
                            {/if}
                        {/block}
                    </li>
                {/foreach}
            {/block}
        </ul>
    {/function}

    <div class="advanced-menu" data-advanced-menu="true">
        {block name="frontend_plugins_advanced_menu"}
            {foreach $sAdvancedMenu as $mainCategory}
                {if !$mainCategory.active || $mainCategory.hidetop}
                    {continue}
                {/if}

                {$hasCategories = $mainCategory.activeCategories > 0  && $columnAmount < 4}
                {$hasTeaser = (!empty($mainCategory.media) || !empty($mainCategory.cmsHeadline) || !empty($mainCategory.cmsText)) && $columnAmount > 0}

                <div class="menu--container">
                    {block name="frontend_plugins_advanced_menu_main_container"}
                        <div class="button-container">
                            {block name="frontend_plugins_advanced_menu_button_category"}
                                <a href="{$mainCategory.link}" class="button--category" title="{s name="toCategoryBtn" namespace="frontend/plugins/advanced_menu/advanced_menu"}{/s}{$categories.name}">
                                    <i class="icon--arrow-right"></i>
                                    {s name="toCategoryBtn" namespace="frontend/plugins/advanced_menu/advanced_menu"}{/s}{$mainCategory.name}
                                </a>
                            {/block}

                            {block name="frontend_plugins_advanced_menu_button_close"}
                                <span class="button--close">
                                    <i class="icon--cross"></i>
                                </span>
                            {/block}
                        </div>

                        {if $hasCategories || $hasTeaser}
                            <div class="content--wrapper{if $hasCategories} has--content{/if}{if $hasTeaser} has--teaser{/if}">
                                {if $hasCategories}
                                    {block name="frontend_plugins_advanced_menu_sub_categories"}
                                        {call name="categories_top" categories=$mainCategory.sub}
                                    {/block}
                                {/if}

                                {if $hasTeaser}
                                    <div class="menu--teaser{if $hasCategories} has--border{/if}"{if $hasCategories} style="width: {$columnAmount * 25}%;"{/if}>
                                        {if !empty($mainCategory.media)}
                                            <div class="teaser--image" style="background-image: url({link file={$mainCategory.media.path}});"></div>
                                        {/if}

                                        {if !empty($mainCategory.cmsHeadline)}
                                            <h2 class="teaser--headline">{$mainCategory.cmsHeadline}</h2>
                                        {/if}

                                        {if !empty($mainCategory.cmsText)}
                                            <div class="teaser--text">
                                                {$mainCategory.cmsText|truncate:250:"..."}
                                                <a class="teaser--text-link" href="{$mainCategory.link}">mehr erfahren</a>
                                            </div>
                                        {/if}
                                    </div>
                                {/if}
                            </div>
                        {/if}
                    {/block}
                </div>
            {/foreach}
        {/block}
    </div>
{/block}

