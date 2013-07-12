


<!DOCTYPE html>
<html>
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# githubog: http://ogp.me/ns/fb/githubog#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>MyProj1/app/helpers/baysmaintenance_helper.rb at master · JagannathLenka/MyProj1</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <link rel="logo" type="image/svg" href="https://github-media-downloads.s3.amazonaws.com/github-logo.svg" />
    <meta property="og:image" content="https://github.global.ssl.fastly.net/images/modules/logos_page/Octocat.png">
    <meta name="hostname" content="fe4.rs.github.com">
    <link rel="assets" href="https://github.global.ssl.fastly.net/">
    <link rel="xhr-socket" href="/_sockets" />
    
    


    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="github" name="octolytics-app-id" /><meta content="3957242" name="octolytics-actor-id" /><meta content="JagannathLenka" name="octolytics-actor-login" /><meta content="a99db0afc57f9cc7944a0f456ceaf9d177de37913fb3e26b6147024a3ee7c536" name="octolytics-actor-hash" />

    
    
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />

    <meta content="authenticity_token" name="csrf-param" />
<meta content="dUd0bNb8PGCaDSqxJA4f1aPCPQ4PVmwvopAPWzu4ruA=" name="csrf-token" />

    <link href="https://github.global.ssl.fastly.net/assets/github-18426ad2e511ad881d5d0a2b133329f94baf1305.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://github.global.ssl.fastly.net/assets/github2-13a1767e53653178a55a8f1aa8fc7567598b5369.css" media="all" rel="stylesheet" type="text/css" />
    


      <script src="https://github.global.ssl.fastly.net/assets/frameworks-e8054ad804a1cf9e9849130fee5a4a5487b663ed.js" type="text/javascript"></script>
      <script src="https://github.global.ssl.fastly.net/assets/github-6db070a7fd82c30d0b0bf14595d2913f6fa7886c.js" type="text/javascript"></script>
      
      <meta http-equiv="x-pjax-version" content="21891e1ca17c21f965e7fb214199e0f8">

        <link data-pjax-transient rel='permalink' href='/JagannathLenka/MyProj1/blob/fd2dd7a6e19af9f0bd4c9d3877589eb1073b56df/app/helpers/baysmaintenance_helper.rb'>
  <meta property="og:title" content="MyProj1"/>
  <meta property="og:type" content="githubog:gitrepository"/>
  <meta property="og:url" content="https://github.com/JagannathLenka/MyProj1"/>
  <meta property="og:image" content="https://github.global.ssl.fastly.net/images/gravatars/gravatar-user-420.png"/>
  <meta property="og:site_name" content="GitHub"/>
  <meta property="og:description" content="MyProj1 - Warehouse Layout"/>

  <meta name="description" content="MyProj1 - Warehouse Layout" />

  <meta content="3957242" name="octolytics-dimension-user_id" /><meta content="JagannathLenka" name="octolytics-dimension-user_login" /><meta content="11180076" name="octolytics-dimension-repository_id" /><meta content="JagannathLenka/MyProj1" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="11180076" name="octolytics-dimension-repository_network_root_id" /><meta content="JagannathLenka/MyProj1" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/JagannathLenka/MyProj1/commits/master.atom" rel="alternate" title="Recent Commits to MyProj1:master" type="application/atom+xml" />

  </head>


  <body class="logged_in page-blob windows vis-public env-production ">

    <div class="wrapper">
      
      
      


      <div class="header header-logged-in true">
  <div class="container clearfix">

    <a class="header-logo-invertocat" href="https://github.com/">
  <span class="mega-octicon octicon-mark-github"></span>
</a>

    <div class="divider-vertical"></div>

      <a href="/notifications" class="notification-indicator tooltipped downwards" title="You have no unread notifications">
    <span class="mail-status all-read"></span>
  </a>
  <div class="divider-vertical"></div>


      <div class="command-bar js-command-bar  in-repository">
          <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<input type="text" data-hotkey="/ s" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    data-username="JagannathLenka"
      data-repo="JagannathLenka/MyProj1"
      data-branch="master"
      data-sha="15169d3b6427ea441f10bf3884a2cacfa76851f3"
  >

    <input type="hidden" name="nwo" value="JagannathLenka/MyProj1" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="octicon help tooltipped downwards" title="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
        <ul class="top-nav">
            <li class="explore"><a href="/explore">Explore</a></li>
            <li><a href="https://gist.github.com">Gist</a></li>
            <li><a href="/blog">Blog</a></li>
          <li><a href="https://help.github.com">Help</a></li>
        </ul>
      </div>

    

  

    <ul id="user-links">
      <li>
        <a href="/JagannathLenka" class="name">
          <img height="20" src="https://secure.gravatar.com/avatar/eace33b9a9ce36cbb894590c238d6105?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /> JagannathLenka
        </a>
      </li>

        <li>
          <a href="/new" id="new_repo" class="tooltipped downwards" title="Create a new repo">
            <span class="octicon octicon-repo-create"></span>
          </a>
        </li>

        <li>
          <a href="/settings/profile" id="account_settings"
            class="tooltipped downwards"
            title="Account settings ">
            <span class="octicon octicon-tools"></span>
          </a>
        </li>
        <li>
          <a class="tooltipped downwards" href="/logout" data-method="post" id="logout" title="Sign out">
            <span class="octicon octicon-log-out"></span>
          </a>
        </li>

    </ul>


<div class="js-new-dropdown-contents hidden">
  

<ul class="dropdown-menu">
  <li>
    <a href="/new"><span class="octicon octicon-repo-create"></span> New repository</a>
  </li>
  <li>
    <a href="/organizations/new"><span class="octicon octicon-organization"></span> New organization</a>
  </li>



    <li class="section-title">
      <span title="JagannathLenka/MyProj1">This repository</span>
    </li>
    <li>
      <a href="/JagannathLenka/MyProj1/issues/new"><span class="octicon octicon-issue-opened"></span> New issue</a>
    </li>
      <li>
        <a href="/JagannathLenka/MyProj1/settings/collaboration"><span class="octicon octicon-person-add"></span> New collaborator</a>
      </li>
</ul>

</div>


    
  </div>
</div>

      

      




          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        

<ul class="pagehead-actions">

    <li class="subscription">
      <form accept-charset="UTF-8" action="/notifications/subscribe" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="dUd0bNb8PGCaDSqxJA4f1aPCPQ4PVmwvopAPWzu4ruA=" /></div>  <input id="repository_id" name="repository_id" type="hidden" value="11180076" />

    <div class="select-menu js-menu-container js-select-menu">
      <span class="minibutton select-menu-button  js-menu-target">
        <span class="js-select-button">
          <span class="octicon octicon-eye-unwatch"></span>
          Unwatch
        </span>
      </span>

      <div class="select-menu-modal-holder">
        <div class="select-menu-modal subscription-menu-modal js-menu-content">
          <div class="select-menu-header">
            <span class="select-menu-title">Notification status</span>
            <span class="octicon octicon-remove-close js-menu-close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-list js-navigation-container">

            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_included" name="do" type="radio" value="included" />
                <h4>Not watching</h4>
                <span class="description">You only receive notifications for discussions in which you participate or are @mentioned.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye-watch"></span>
                  Watch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input checked="checked" id="do_subscribed" name="do" type="radio" value="subscribed" />
                <h4>Watching</h4>
                <span class="description">You receive notifications for all discussions in this repository.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye-unwatch"></span>
                  Unwatch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_ignore" name="do" type="radio" value="ignore" />
                <h4>Ignoring</h4>
                <span class="description">You do not receive any notifications for discussions in this repository.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-mute"></span>
                  Stop ignoring
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

</form>
    </li>

    <li class="js-toggler-container js-social-container starring-container ">
      <a href="/JagannathLenka/MyProj1/unstar" class="minibutton with-count js-toggler-target star-button starred upwards" title="Unstar this repo" data-remote="true" data-method="post" rel="nofollow">
        <span class="octicon octicon-star-delete"></span><span class="text">Unstar</span>
      </a>
      <a href="/JagannathLenka/MyProj1/star" class="minibutton with-count js-toggler-target star-button unstarred upwards" title="Star this repo" data-remote="true" data-method="post" rel="nofollow">
        <span class="octicon octicon-star"></span><span class="text">Star</span>
      </a>
      <a class="social-count js-social-count" href="/JagannathLenka/MyProj1/stargazers">0</a>
    </li>

        <li>
          <a href="/JagannathLenka/MyProj1/fork" class="minibutton with-count js-toggler-target fork-button lighter upwards" title="Fork this repo" rel="nofollow" data-method="post">
            <span class="octicon octicon-git-branch-create"></span><span class="text">Fork</span>
          </a>
          <a href="/JagannathLenka/MyProj1/network" class="social-count">0</a>
        </li>


</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author">
            <a href="/JagannathLenka" class="url fn" itemprop="url" rel="author"><span itemprop="title">JagannathLenka</span></a></span
          ><span class="repohead-name-divider">/</span><strong
          ><a href="/JagannathLenka/MyProj1" class="js-current-repository js-repo-home-link">MyProj1</a></strong>

          <span class="page-context-loader">
            <img alt="Octocat-spinner-32" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">

      <div class="repository-with-sidebar repo-container
            ">

          <div class="repository-sidebar">

              

<div class="repo-nav repo-nav-full js-repository-container-pjax js-octicon-loaders">
  <div class="repo-nav-contents">
    <ul class="repo-menu">
      <li class="tooltipped leftwards" title="Code">
        <a href="/JagannathLenka/MyProj1" class="js-selected-navigation-item selected" data-gotokey="c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_tags repo_branches /JagannathLenka/MyProj1">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped leftwards" title="Issues">
          <a href="/JagannathLenka/MyProj1/issues" class="js-selected-navigation-item js-disable-pjax" data-gotokey="i" data-selected-links="repo_issues /JagannathLenka/MyProj1/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class='counter'>0</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped leftwards" title="Pull Requests"><a href="/JagannathLenka/MyProj1/pulls" class="js-selected-navigation-item js-disable-pjax" data-gotokey="p" data-selected-links="repo_pulls /JagannathLenka/MyProj1/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class='counter'>0</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


        <li class="tooltipped leftwards" title="Wiki">
          <a href="/JagannathLenka/MyProj1/wiki" class="js-selected-navigation-item " data-pjax="true" data-selected-links="repo_wiki /JagannathLenka/MyProj1/wiki">
            <span class="octicon octicon-book"></span> <span class="full-word">Wiki</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>


    </ul>
    <div class="repo-menu-separator"></div>
    <ul class="repo-menu">

      <li class="tooltipped leftwards" title="Pulse">
        <a href="/JagannathLenka/MyProj1/pulse" class="js-selected-navigation-item " data-pjax="true" data-selected-links="pulse /JagannathLenka/MyProj1/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped leftwards" title="Graphs">
        <a href="/JagannathLenka/MyProj1/graphs" class="js-selected-navigation-item " data-pjax="true" data-selected-links="repo_graphs repo_contributors /JagannathLenka/MyProj1/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped leftwards" title="Network">
        <a href="/JagannathLenka/MyProj1/network" class="js-selected-navigation-item js-disable-pjax" data-selected-links="repo_network /JagannathLenka/MyProj1/network">
          <span class="octicon octicon-git-branch"></span> <span class="full-word">Network</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

    </ul>

      <div class="repo-menu-separator"></div>
      <ul class="repo-menu">
        <li class="tooltipped leftwards" title="Settings">
          <a href="/JagannathLenka/MyProj1/settings" data-pjax>
            <span class="octicon octicon-tools"></span> <span class="full-word">Settings</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
          </a>
        </li>
      </ul>
  </div>
</div>


              <div class="only-with-full-nav">

                

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=push">
  <h3><strong>HTTPS</strong> clone URL</h3>

  <input type="text" class="clone js-url-field"
         value="https://github.com/JagannathLenka/MyProj1.git" readonly="readonly">

  <span class="js-zeroclipboard url-box-clippy minibutton zeroclipboard-button" data-clipboard-text="https://github.com/JagannathLenka/MyProj1.git" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
</div>

  

<div class="clone-url "
  data-protocol-type="ssh"
  data-url="/users/set_protocol?protocol_selector=ssh&amp;protocol_type=push">
  <h3><strong>SSH</strong> clone URL</h3>

  <input type="text" class="clone js-url-field"
         value="git@github.com:JagannathLenka/MyProj1.git" readonly="readonly">

  <span class="js-zeroclipboard url-box-clippy minibutton zeroclipboard-button" data-clipboard-text="git@github.com:JagannathLenka/MyProj1.git" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=push">
  <h3><strong>Subversion</strong> checkout URL</h3>

  <input type="text" class="clone js-url-field"
         value="https://github.com/JagannathLenka/MyProj1" readonly="readonly">

  <span class="js-zeroclipboard url-box-clippy minibutton zeroclipboard-button" data-clipboard-text="https://github.com/JagannathLenka/MyProj1" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
</div>



<p class="clone-options">You can clone with
    <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>,
    <a href="#" class="js-clone-selector" data-protocol="ssh">SSH</a>,
    <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>,
  and <a href="https://help.github.com/articles/which-remote-url-should-i-use">other methods.</a>
</p>


  <a href="github-windows://openRepo/https://github.com/JagannathLenka/MyProj1" class="minibutton sidebar-button">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>


                  <a href="/JagannathLenka/MyProj1/archive/master.zip"
                     class="minibutton sidebar-button"
                     title="Download this repository as a zip file"
                     rel="nofollow">
                    <span class="octicon octicon-cloud-download"></span>
                    Download ZIP
                  </a>

              </div>
          </div>

          <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
            


<!-- blob contrib key: blob_contributors:v21:0af3400a40cf807b5899aa6e6ea2843f -->
<!-- blob contrib frag key: views10/v8/blob_contributors:v21:0af3400a40cf807b5899aa6e6ea2843f -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<a href="/JagannathLenka/MyProj1/find/master" data-pjax data-hotkey="t" style="display:none">Show File Finder</a>

<div class="file-navigation">
  


<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target" data-hotkey="w"
    data-master-branch="master"
    data-ref="master">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax>

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-remove-close js-menu-close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Find or create a branch…">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/JagannathLenka/MyProj1/blob/master/app/helpers/baysmaintenance_helper.rb" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="master" rel="nofollow" title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <form accept-charset="UTF-8" action="/JagannathLenka/MyProj1/branches" class="js-create-branch select-menu-item select-menu-new-item-form js-navigation-item js-new-item-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="dUd0bNb8PGCaDSqxJA4f1aPCPQ4PVmwvopAPWzu4ruA=" /></div>
            <span class="octicon octicon-git-branch-create select-menu-item-icon"></span>
            <div class="select-menu-item-text">
              <h4>Create branch: <span class="js-new-item-name"></span></h4>
              <span class="description">from ‘master’</span>
            </div>
            <input type="hidden" name="name" id="name" class="js-new-item-value">
            <input type="hidden" name="branch" id="branch" value="master" />
            <input type="hidden" name="path" id="branch" value="app/helpers/baysmaintenance_helper.rb" />
          </form> <!-- /.select-menu-item -->

      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/JagannathLenka/MyProj1" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">MyProj1</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/JagannathLenka/MyProj1/tree/master/app" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">app</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/JagannathLenka/MyProj1/tree/master/app/helpers" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">helpers</span></a></span><span class="separator"> / </span><strong class="final-path">baysmaintenance_helper.rb</strong> <span class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="app/helpers/baysmaintenance_helper.rb" data-copied-hint="copied!" title="copy to clipboard"><span class="octicon octicon-clippy"></span></span>
  </div>
</div>


  
  <div class="commit file-history-tease">
    <img class="main-avatar" height="24" src="https://secure.gravatar.com/avatar/320661a5cd982a01c0daa414fc4c24f8?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="24" />
    <span class="author"><span rel="author">unknown</span></span>
    <time class="js-relative-date" datetime="2013-07-11T00:17:43-07:00" title="2013-07-11 00:17:43">July 11, 2013</time>
    <div class="commit-title">
        <a href="/JagannathLenka/MyProj1/commit/fd2dd7a6e19af9f0bd4c9d3877589eb1073b56df" class="message" data-pjax="true">Bug fix for drag and drop and JQGrid</a>
    </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>0</strong> contributors</a></p>
      
    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
      </ul>
    </div>
  </div>


<div id="files" class="bubble">
  <div class="file">
    <div class="meta">
      <div class="info">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">file</span>
          <span>51 lines (38 sloc)</span>
        <span>2.209 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
                <a class="minibutton"
                   href="/JagannathLenka/MyProj1/edit/master/app/helpers/baysmaintenance_helper.rb"
                   data-method="post" rel="nofollow" data-hotkey="e">Edit</a>
          <a href="/JagannathLenka/MyProj1/raw/master/app/helpers/baysmaintenance_helper.rb" class="button minibutton " id="raw-url">Raw</a>
            <a href="/JagannathLenka/MyProj1/blame/master/app/helpers/baysmaintenance_helper.rb" class="button minibutton ">Blame</a>
          <a href="/JagannathLenka/MyProj1/commits/master/app/helpers/baysmaintenance_helper.rb" class="button minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->
            <a class="minibutton danger empty-icon tooltipped downwards"
               href="/JagannathLenka/MyProj1/delete/master/app/helpers/baysmaintenance_helper.rb"
               title="" data-method="post" rel="nofollow">
            Delete
          </a>
      </div><!-- /.actions -->

    </div>
        <div class="blob-wrapper data type-ruby js-blob-data">
      <table class="file-code file-diff">
        <tr class="file-code-line">
          <td class="blob-line-nums">
            <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>

          </td>
          <td class="blob-line-code">
                  <div class="highlight"><pre><div class='line' id='LC1'><span class="k">module</span> <span class="nn">BaysmaintenanceHelper</span></div><div class='line' id='LC2'>&nbsp;&nbsp;&nbsp;&nbsp;</div><div class='line' id='LC3'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="kp">include</span> <span class="no">JqgridsHelper</span></div><div class='line' id='LC4'><br/></div><div class='line' id='LC5'>&nbsp;&nbsp;<span class="k">def</span> <span class="nf">bays_jqgrid</span></div><div class='line' id='LC6'><br/></div><div class='line' id='LC7'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">options</span> <span class="o">=</span> <span class="p">{</span><span class="ss">:on_document_ready</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">,</span> <span class="ss">:html_tags</span> <span class="o">=&gt;</span> <span class="kp">false</span><span class="p">}</span></div><div class='line' id='LC8'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">url</span> <span class="o">=</span> <span class="s2">&quot;/baysmaintenance/ </span><span class="si">#{</span><span class="n">params</span><span class="o">[</span><span class="ss">:id</span><span class="o">]</span><span class="si">}</span><span class="s2">&quot;</span></div><div class='line' id='LC9'>&nbsp;</div><div class='line' id='LC10'><br/></div><div class='line' id='LC11'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">grid</span> <span class="o">=</span> <span class="o">[</span><span class="p">{</span></div><div class='line' id='LC12'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:url</span> <span class="o">=&gt;</span> <span class="n">url</span> <span class="p">,</span></div><div class='line' id='LC13'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:datatype</span> <span class="o">=&gt;</span> <span class="s1">&#39;json&#39;</span><span class="p">,</span></div><div class='line' id='LC14'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:mtype</span> <span class="o">=&gt;</span> <span class="s1">&#39;GET&#39;</span><span class="p">,</span></div><div class='line' id='LC15'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:colNames</span> <span class="o">=&gt;</span> <span class="o">[</span><span class="s1">&#39;id&#39;</span><span class="p">,</span> <span class="s1">&#39;bay_id&#39;</span><span class="p">,</span><span class="s1">&#39;customer_bay_id&#39;</span><span class="p">,</span> <span class="s1">&#39;properties1&#39;</span><span class="p">,</span><span class="s1">&#39;properties2&#39;</span><span class="p">,</span><span class="s1">&#39;properties3&#39;</span><span class="p">,</span> <span class="s1">&#39;aisle_id&#39;</span><span class="o">]</span><span class="p">,</span></div><div class='line' id='LC16'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:colModel</span>  <span class="o">=&gt;</span> <span class="o">[</span></div><div class='line' id='LC17'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;id&#39;</span><span class="p">,</span>   <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;id&#39;</span><span class="p">,</span>    <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">55</span><span class="p">,</span> <span class="ss">formatter</span><span class="p">:</span><span class="s1">&#39;showlink&#39;</span><span class="p">,</span> <span class="ss">formatoptions</span><span class="p">:{</span><span class="ss">baseLinkUrl</span><span class="p">:</span><span class="s1">&#39;/baysmaintenance&#39;</span><span class="p">}},</span></div><div class='line' id='LC18'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;bay_id&#39;</span><span class="p">,</span>   <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;bay_id&#39;</span><span class="p">,</span>    <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">55</span><span class="p">,</span> <span class="ss">:align</span> <span class="o">=&gt;</span> <span class="s1">&#39;right&#39;</span><span class="p">,</span> <span class="ss">:editable</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">},</span></div><div class='line' id='LC19'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;customer_bay_id&#39;</span><span class="p">,</span> <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;customer_bay_id&#39;</span><span class="p">,</span>  <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">190</span><span class="p">,</span> <span class="ss">:align</span> <span class="o">=&gt;</span> <span class="s1">&#39;right&#39;</span><span class="p">,</span> <span class="ss">:editable</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">},</span></div><div class='line' id='LC20'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;properties1&#39;</span><span class="p">,</span>  <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;properties1&#39;</span><span class="p">,</span>   <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">80</span><span class="p">,</span>   <span class="ss">:align</span> <span class="o">=&gt;</span> <span class="s1">&#39;right&#39;</span><span class="p">,</span> <span class="ss">:editable</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">},</span></div><div class='line' id='LC21'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;properties2&#39;</span><span class="p">,</span>     <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;properties2&#39;</span><span class="p">,</span>      <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">80</span><span class="p">,</span>   <span class="ss">:align</span> <span class="o">=&gt;</span> <span class="s1">&#39;right&#39;</span><span class="p">,</span> <span class="ss">:editable</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">},</span></div><div class='line' id='LC22'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;properties3&#39;</span><span class="p">,</span>   <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;properties3&#39;</span><span class="p">,</span>    <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">80</span><span class="p">,</span>   <span class="ss">:align</span> <span class="o">=&gt;</span> <span class="s1">&#39;right&#39;</span><span class="p">,</span> <span class="ss">:editable</span> <span class="o">=&gt;</span> <span class="kp">true</span> <span class="p">},</span></div><div class='line' id='LC23'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">{</span> <span class="ss">:name</span> <span class="o">=&gt;</span> <span class="s1">&#39;aisle_id&#39;</span><span class="p">,</span>    <span class="ss">:index</span> <span class="o">=&gt;</span> <span class="s1">&#39;aisle_id&#39;</span><span class="p">,</span>     <span class="ss">:width</span> <span class="o">=&gt;</span> <span class="mi">150</span><span class="p">,</span>  <span class="ss">:align</span> <span class="o">=&gt;</span> <span class="s1">&#39;right&#39;</span><span class="p">,</span> <span class="ss">:editable</span> <span class="o">=&gt;</span> <span class="kp">true</span> <span class="p">}</span></div><div class='line' id='LC24'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="o">]</span><span class="p">,</span></div><div class='line' id='LC25'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:editurl</span> <span class="o">=&gt;</span> <span class="s1">&#39;/baysmaintenance&#39;</span><span class="p">,</span></div><div class='line' id='LC26'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:pager</span> <span class="o">=&gt;</span> <span class="s1">&#39;#bays_pager&#39;</span><span class="p">,</span></div><div class='line' id='LC27'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:rowNum</span> <span class="o">=&gt;</span> <span class="mi">10</span><span class="p">,</span></div><div class='line' id='LC28'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:rowList</span> <span class="o">=&gt;</span> <span class="o">[</span><span class="mi">10</span><span class="p">,</span> <span class="mi">20</span><span class="p">,</span> <span class="mi">30</span><span class="o">]</span><span class="p">,</span></div><div class='line' id='LC29'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:sortname</span> <span class="o">=&gt;</span> <span class="s1">&#39;bay_id&#39;</span><span class="p">,</span></div><div class='line' id='LC30'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:sortorder</span> <span class="o">=&gt;</span> <span class="s1">&#39;desc&#39;</span><span class="p">,</span></div><div class='line' id='LC31'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:viewrecords</span> <span class="o">=&gt;</span> <span class="kp">true</span><span class="p">,</span></div><div class='line' id='LC32'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:caption</span> <span class="o">=&gt;</span> <span class="s1">&#39;Bay Maintenance&#39;</span><span class="p">,</span></div><div class='line' id='LC33'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="ss">:onSelectRow</span> <span class="o">=&gt;</span> <span class="s2">&quot;function() { alert(&#39;Row selected!&#39;);}&quot;</span><span class="o">.</span><span class="n">to_json_var</span></div><div class='line' id='LC34'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="p">}</span><span class="o">]</span></div><div class='line' id='LC35'><br/></div><div class='line' id='LC36'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c1"># See http://www.trirand.com/jqgridwiki/doku.php?id=wiki:navigator</span></div><div class='line' id='LC37'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c1"># (&#39;navGrid&#39;,&#39;#gridpager&#39;,{parameters}, prmEdit, prmAdd, prmDel, prmSearch, prmView)</span></div><div class='line' id='LC38'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="c1">#pager = [:navGrid, &quot;#aisle_pager&quot;, {:del =&gt; true}, {:closeAfterEdit =&gt; true, :closeOnEscape =&gt; true}, {}, {}, {}, {}]</span></div><div class='line' id='LC39'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">pager</span> <span class="o">=</span> <span class="o">[</span><span class="ss">:navGrid</span><span class="p">,</span> <span class="s2">&quot;#bays_pager&quot;</span><span class="p">,</span> <span class="p">{</span><span class="ss">edit</span><span class="p">:</span><span class="kp">false</span><span class="p">,</span><span class="ss">add</span><span class="p">:</span><span class="kp">false</span><span class="p">,</span><span class="ss">del</span><span class="p">:</span><span class="kp">false</span><span class="p">}</span><span class="o">]</span></div><div class='line' id='LC40'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">pager2</span> <span class="o">=</span> <span class="o">[</span><span class="ss">:inlineNav</span><span class="p">,</span> <span class="s2">&quot;#bays_pager&quot;</span><span class="o">]</span></div><div class='line' id='LC41'><br/></div><div class='line' id='LC42'>&nbsp;&nbsp;&nbsp;&nbsp;</div><div class='line' id='LC43'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">pager_button</span> <span class="o">=</span> <span class="o">[</span><span class="ss">:navButtonAdd</span><span class="p">,</span> <span class="s2">&quot;#bays_pager&quot;</span><span class="p">,</span> <span class="p">{</span><span class="ss">:caption</span> <span class="o">=&gt;</span> <span class="s1">&#39;Add&#39;</span><span class="p">,</span> <span class="ss">:onClickButton</span> <span class="o">=&gt;</span> <span class="s1">&#39;function() {alert(&quot;Custom button!&quot;)}&#39;</span><span class="o">.</span><span class="n">to_json_var</span> <span class="p">}</span><span class="o">]</span></div><div class='line' id='LC44'><br/></div><div class='line' id='LC45'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">jqgrid_api</span> <span class="s1">&#39;bays_list&#39;</span><span class="p">,</span> <span class="n">grid</span><span class="p">,</span> <span class="n">pager</span><span class="p">,</span> <span class="n">pager2</span><span class="p">,</span> <span class="n">pager_button</span><span class="p">,</span> <span class="n">options</span></div><div class='line' id='LC46'><br/></div><div class='line' id='LC47'>&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC48'><br/></div><div class='line' id='LC49'>&nbsp;&nbsp;</div><div class='line' id='LC50'><span class="k">end</span></div></pre></div>
          </td>
        </tr>
      </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

          </div>
        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div>
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/">
      <span class="mega-octicon octicon-mark-github"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2013 <span title="0.05546s from fe4.rs.github.com">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
          <div class="suggester-container">
              <div class="suggester fullscreen-suggester js-navigation-container" id="fullscreen_suggester"
                 data-url="/JagannathLenka/MyProj1/suggestions/commit">
              </div>
          </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped leftwards" title="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped leftwards"
      title="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-remove-close close ajax-error-dismiss"></a>
      Something went wrong with that request. Please try again.
    </div>

    
  </body>
</html>

