webpackJsonp([2],{0:function(t,e,n){n(50),n(51),n(10),n(114),n(115),n(27),n(28),n(53),n(87),n(14),n(117),n(31),n(119),n(52),n(29),n(118),n(22),n(24),n(30),n(55),n(56),t.exports=n(57)},10:function(t,e,n){var r,o,i,a,u,s,l,p,c,d,f,_,v,h,m,y,b,g,w,x,M;r=n(7),i=n(8),o=n(2),a=function(t){return t.replace(/([A-Z])/g,function(t){return"-"+t.toLowerCase()})},u=function(t){return t.charAt(0).toUpperCase()+t.slice(1)},s=function(t,e){var n,r,o;r=t.create();for(n in e)o=e[n],r.set(n,o);return t.add(r),t.save()},l=function(t,e,n){var r,o;return r=new n,t.reply("main-controller",function(){return r}),o=new e({controller:r})},p=function(t,e){var n;return n=t.get(e),void 0===n?new t.model({id:e}):n},c=function(t){return console.warn("handle_newlines being replaced by newline_2_br"),t.replace(/(?:\r\n|\r|\n)/g,"<br />")},d=function(t){var e,n,r,o;for(o={},n=0,r=t.length;n<r;n++)e=t[n],o[e]='input[name="'+e+'"]';return o},_=function(t,e,n){var r;return null==n&&(n="POST"),r={type:n,url:t,data:JSON.stringify(e),accepts:"application/json",contentType:"application/json"}},f=function(t,e,n){var o;return null==n&&(n="POST"),o=_(t,e,n),r.ajax(o)},v=function(t,e){return t.reply("get-navbar-color",function(){var t;return t=r(e),t.css("color")}),t.reply("get-navbar-bg-color",function(){var t;return t=r(e),t.css("background-color")})},h=function(t){var e,n,o,i,a,u,s;for(a=t.split("/")[0],u=r("#navbar-view li"),s=[],e=0,n=u.length;e<n;e++)o=u[e],i=r(o),i.removeClass("active"),a===i.attr("appname")?s.push(i.addClass("active")):s.push(void 0);return s},m=function(t){var e;return""===t.split("/")[0]?window.location=t:(e=new o.Router,e.navigate(t,{trigger:!0}))},y=function(t){return t.replace(/(?:\r\n|\r|\n)/g,"<br />")},b=function(t){var e;return e=Math.floor(Math.random()*t.length),t[e]},g=function(t){return t.replace(/\/$/,"")},w=function(){return window.scrollTo(0,0)},x=function(){return r("html, body").animate({scrollTop:0},"fast")},M=function(t,e){var n,r;return r=this.toString(),("number"!=typeof e||!isFinite(e)||Math.floor(e)!==e||e>r.length)&&(e=r.length),e-=t.length,n=r.indexOf(t,e),n!==-1&&n===e},t.exports={camel_to_kebab:a,capitalize:u,create_model:s,create_new_approuter:l,get_model:p,handle_newlines:c,make_field_input_ui:d,make_json_post_settings:_,make_json_post:f,navbar_color_handlers:v,navbar_set_active:h,navigate_to_url:m,random_choice:b,remove_trailing_slashes:g,scroll_top_fast:w,scroll_top_fast_jquery:x,string_endswith:M}},14:function(t,e,n){var r,o,i,a,u,s,l=function(t,e){function n(){this.constructor=t}for(var r in e)p.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},p={}.hasOwnProperty;r=n(2),a=n(3),i=r.Radio.channel("global"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.attachHtml=function(t){var e;return e=this.slide_speed?this.slide_speed:"fast",this.$el.hide(),this.$el.html(t.el),this.$el.slideDown(e)},e}(r.Marionette.Region),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e.prototype.el="#modal",e.prototype.backdrop=!1,e.prototype.getEl=function(t){var e;return e=$(t),e.attr("class","modal"),e},e.prototype.show=function(t){return e.__super__.show.call(this,t),this.$el.modal({backdrop:this.backdrop}),this.$el.modal("show")},e}(r.Marionette.Region),s=function(t,e){var n;return null==e&&(e=!1),n=i.request("main:app:get-region","modal"),n.backdrop=e,n.show(t)},t.exports={BootstrapModalRegion:o,show_modal:s,SlideDownRegion:u,modal:o,slideDown:u}},22:function(t,e,n){var r,o,i,a,u,s;s=n(4),u=s.component(function(t,e,n){return s.span(t+".btn.btn-default.btn-xs",n)}),r=s.component(function(t,e,n){return s.div(t+".btn.btn-default.btn-xs",n)}),i=s.renderable(function(t,e){return null==t&&(t="Close"),null==e&&(e="close"),s.div(".btn.btn-default.btn-xs",{"data-dismiss":"modal"},function(){return s.h4(".modal-title",function(){return s.i(".fa.fa-"+e),s.text(t)})})}),a=s.renderable(function(t){return s.button(".navbar-toggle",{type:"button","data-toggle":"collapse","data-target":"#"+t},function(){return s.span(".sr-only","Toggle Navigation"),s.span(".icon-bar"),s.span(".icon-bar"),s.span(".icon-bar")})}),o=s.component(function(t,e,n){return s.a(t+".dropdown-toggle",{href:e.href,"data-toggle":"dropdown"},n)}),t.exports={spanbutton:u,divbutton:r,modal_close_button:i,navbar_collapse_button:a,dropdown_toggle:o}},24:function(t,e,n){var r,o,i,a,u,s,l,p,c;c=n(4),r=n(10).capitalize,o=c.renderable(function(t){return c.div(".form-group",function(){var e,n,r;return c.label(".control-label",{for:t.input_id},t.label),r="#"+t.input_id+".form-control",e=t.input_attributes,n=c.input,(null!=t?t.input_type:void 0)?(n=c[t.input_type])(r,e,function(){return c.text(null!=t?t.content:void 0)}):n(r,e)})}),a=function(t){return c.renderable(function(e){return o({input_id:"input_"+t,label:r(t),input_attributes:{name:t,placeholder:t,value:e[t]}})})},s=function(t){return c.renderable(function(e){return o({input_id:"input_"+t,input_type:"textarea",label:r(t),input_attributes:{name:t,placeholder:t},content:e[t]})})},u=function(t,e){return c.renderable(function(n){return c.div(".form-group",function(){return c.label(".control-label",{for:"select_"+t}),r(t)}),c.select(".form-control",{name:"select_"+t},function(){var r,o,i,a;for(a=[],r=0,o=e.length;r<o;r++)i=e[r],n[t]===i?a.push(c.option({selected:null,value:i},i)):a.push(c.option({value:i},i));return a})})},l=function(t,e){return null==t&&(t="/login"),null==e&&(e="POST"),c.renderable(function(n){return c.form({role:"form",method:e,action:t},function(){return o({input_id:"input_username",label:"User Name",input_attributes:{name:"username",placeholder:"User Name"}}),o({input_id:"input_password",label:"Password",input_attributes:{name:"password",type:"password",placeholder:"Type your password here...."}}),c.button(".btn.btn-default",{type:"submit"},"login")})})},i=l(),p=c.renderable(function(t){return o({input_id:"input_name",label:"Name",input_attributes:{name:"name",placeholder:"Name"}}),o({input_id:"input_content",input_type:c.textarea,label:"Content",input_attributes:{name:"content",placeholder:"..."}}),c.input(".btn.btn-default.btn-xs",{type:"submit",value:"Add"})}),t.exports={form_group_input_div:o,make_field_input:a,make_field_textarea:s,make_field_select:u,make_login_form:l,login_form:i,name_content_form:p}},27:function(t,e,n){var r,o,i,a,u=function(t,e){function n(){this.constructor=t}for(var r in e)s.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},s={}.hasOwnProperty;r=n(2),i=n(3),a=n(10),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return u(e,t),e.prototype.onRoute=function(t,e,n){return a.navbar_set_active(e)},e}(r.Marionette.AppRouter),t.exports=o},28:function(t,e,n){var r,o,i,a,u,s,l,p,c,d=function(t,e){function n(){this.constructor=t}for(var r in e)f.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},f={}.hasOwnProperty;r=n(7),o=n(2),l=n(3),c=n(25),s=n(31),p=n(10),a=o.Radio.channel("global"),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e.prototype.init_page=function(){},e.prototype.scroll_top=p.scroll_top_fast,e.prototype.navigate_to_url=p.navigate_to_url,e.prototype.navbar_set_active=p.navbar_set_active,e}(o.Marionette.Object),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return d(e,t),e.prototype.layoutClass=s.DefaultAppletLayout,e.prototype._get_applet=function(){var t;return t=a.request("main:app:object"),t.getView().getRegion("applet")},e.prototype.setup_layout=function(){var t;return this.layout=new this.layoutClass,t=this._get_applet(),t.hasView()&&t.empty(),t.show(this.layout)},e.prototype.setup_layout_if_needed=function(){return void 0===this.layout?this.setup_layout():this.layout.isDestroyed?this.setup_layout():void 0},e.prototype._get_region=function(t){return this.layout.getRegion(t)},e.prototype._show_content=function(t){var e;return console.warn("_show_content is deprecated"),e=this._get_region("content"),e.show(t)},e.prototype._empty_sidebar=function(){var t;return t=this._get_region("sidebar"),t.empty(),t},e.prototype._make_sidebar=function(){var t,e;return console.warn("_make_sidebar is deprecated"),t=this._empty_sidebar(),e=new this.sidebarclass({model:this.sidebar_model}),t.show(e)},e.prototype._show_view=function(t,e){var n;return n=new t({model:e}),this._show_content(n)},e.prototype._load_view=function(t,e,n){var r;return e.isEmpty()||1===Object.keys(e.attributes).length?(r=e.fetch(),r.done(function(n){return function(){return n._show_view(t,e)}}(this)),r.fail(function(t){return function(){var t;return t="Failed to load "+n+" data.",MessageChannel.request("danger",t)}}(this))):this._show_view(t,e)},e}(i),t.exports={BaseController:i,MainController:u}},29:function(t,e,n){var r,o,i,a,u,s,l,p,c,d,f,_,v=function(t,e){function n(){this.constructor=t}for(var r in e)h.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},h={}.hasOwnProperty;for(r=n(2),a=r.Radio.channel("global"),u=r.Radio.channel("messages"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return v(e,t),e.prototype.defaults={level:"info"},e}(r.Model),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return v(e,t),e.prototype.model=o,e}(r.Collection),f=new i,u.reply("messages",function(){return f}),s=function(t){return function(t,e,n,r){var i,a;return null==n&&(n=!1),null==r&&(r=6e3),a=new o({content:t,level:e,icon:n}),"danger"!==e&&(i=function(){return f.remove(a)},setTimeout(i,r)),f.add(a)}}(this),u.reply("display-message",function(t){return function(t,e,n){return null==e&&(e="info"),null==n&&(n=!1),console.warn("icon",n),s(t,e,n)}}(this)),_=["success","info","warning","danger","brand"],l=function(t){return u.reply(t,function(e){return function(e,n){return null==n&&(n=!1),s(e,t,n)}}(this))},p=0,c=_.length;p<c;p++)d=_[p],l(d);u.reply("delete-message",function(t){return function(t){return f.remove(t)}}(this)),t.exports={BaseMessageCollection:i}},30:function(t,e,n){var r,o,i,a,u,s,l,p;p=n(4),r=p.renderable(function(){return p.div("#main-navbar.navbar.navbar-default.navbar-fixed-top",{role:"navigation"}),p.div(".container-fluid",function(){return p.div(".row",function(){return p.div("#sidebar.col-sm-2"),p.div("#main-content.col-sm-9")})}),p.div("#footer"),p.div("#modal")}),o=p.renderable(function(){return p.div("#main-navbar.navbar.navbar-default.navbar-fixed-top",{role:"navigation"}),p.div(".main-layout",function(){return p.div("#sidebar"),p.div("#main-content")}),p.div("#footer"),p.div("#modal")}),s=p.renderable(function(t){return p.div("#navbar-view-container"),p.div("."+t,function(){return p.div(".row",function(){return p.div(".col-md-10",function(){return p.div("#messages")})}),p.div("#applet-content.row")}),p.div("#footer"),p.div("#modal")}),u=function(){return s("container")},a=function(){return s("container-fluid")},i=p.renderable(function(t){var e;return e=t.data.attributes,p.article(".document-view.content",function(){return p.h1(e.title),p.p(".lead",e.description),p.div(".body",function(){return p.raw(e.body)})})}),l=function(t,e,n){return null==t&&(t=3),null==e&&(e="sm"),null==n&&(n="left"),p.renderable(function(){if("left"===n&&p.div("#sidebar.col-"+e+"-"+t+".left-column"),p.div("#main-content.col-"+e+"-"+(12-t)),"right"===n)return p.div("#sidebar.col-"+e+"-"+t+".right-column")})},t.exports={BootstrapLayoutTemplate:r,BootstrapNoGridLayoutTemplate:o,MainLayoutTemplate:u,MainFluidLayoutTemplate:a,MainContentTemplate:i,make_sidebar_template:l}},31:function(t,e,n){var r,o,i,a,u,s,l,p,c,d,f,_,v,h,m,y,b=function(t,e){function n(){this.constructor=t}for(var r in e)g.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},g={}.hasOwnProperty;r=n(2),c=n(3),m=n(57),u=n(30),h=n(56),d=n(55),o=n(14).BootstrapModalRegion,s=r.Radio.channel("global"),f=r.Radio.channel("messages"),l=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.template=u.MainFluidLayoutTemplate,e.prototype.regions={messages:"#messages",navbar:"#navbar-view-container",modal:o,applet:"#applet-content",footer:"#footer"},e}(r.Marionette.View),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.template=u.make_sidebar_template(),e.prototype.regions={sidebar:"#sidebar",content:"#main-content"},e}(r.Marionette.View),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.template=m.nav_pt,e.prototype.regions={usermenu:"#user-menu",mainmenu:"#main-menu"},e}(r.Marionette.View),p=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.template=m.nav_pt_search,e}(r.Marionette.View),y=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.template=d.user_menu,e}(r.Marionette.View),_=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.template=h.message_box,e.prototype.ui={close_button:"button.close"},e.prototype.events={"click @ui.close_button":"destroy_message"},e.prototype.destroy_message=function(){return f.request("delete-message",this.model)},e}(r.Marionette.View),v=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return b(e,t),e.prototype.childView=_,e}(r.Marionette.CollectionView),t.exports={MainPageLayout:l,DefaultAppletLayout:a,MainSearchFormView:p,BootstrapNavBarView:i,UserMenuView:y,MessagesView:v}},50:function(t,e,n){var r,o,i,a,u,s;r=n(2),i=n(3),n(26),n(29),u=n(31),o=r.Radio.channel("global"),a=r.Radio.channel("messages"),s=function(t){var e,n,r,i;return n=o.request("main:app:appmodel"),e=n.has("appView")?n.get("appView"):u.MainPageLayout,i={},n.has("layout_template")&&(i.template=n.get("layout_template")),r=new e(i),r.on("render",function(){var e,i,s;return o.reply("main:app:get-region",function(e){return console.warn("Don't use this anymore->","main:app:get-region",e),t.getView().getRegion(e)}),s=n.has("navbarView")?n.get("navbarView"):u.BootstrapNavBarView,i=new s({model:n}),r.showChildView("navbar",i),e=new u.MessagesView({collection:a.request("messages")}),r.showChildView("messages",e)}),t.showView(r)},t.exports=s},51:function(t,e,n){var r,o,i,a,u,s,l,p,c;r=n(2),a=n(3),c=n(14),o=c.BootstrapModalRegion,u=c.SlideDownRegion,i=r.Radio.channel("global"),s=function(t){return new a.Application({region:t.get("appRegion"),onStart:function(){var e,n,o,a,u,s,l,p;for(n=t.get("frontdoor_app"),i.request("applet:"+n+":route"),o=t.get("hasUser"),o&&(p=t.get("userprofile_app"),i.request("applet:"+p+":route")),s=t.get("applets"),a=0,u=s.length;a<u;a++)e=s[a],(null!=e?e.appname:void 0)&&(l="applet:"+e.appname+":route",i.request(l));if(i.request("mainpage:init",t),!r.history.started)return r.history.start()}})},l=function(t){var e;return e=s(t),i.reply("main:app:object",function(){return e}),e},p=function(t,e){var n,a,s;return s=e.get("regions"),"modal"in s&&(s.modal=o),"navbar"in s&&(s.navbar=new u({el:s.navbar,speed:"slow"})),"content"in s&&(s.content=new u({el:s.content})),a=new r.Marionette.RegionManager,a.addRegions(s),n=a.get("navbar"),n.on("show",function(t){return function(){return i.trigger("appregion:navbar:displayed")}}(this)),i.reply("main:app:object",function(){return t}),i.reply("main:app:regions",function(){return a}),i.reply("main:app:get-region",function(t){return a.get(t)}),t.on("start",function(){var t,n,o,a,u,s,l;for(n=e.get("frontdoor_app"),i.request("applet:"+n+":route"),o=e.get("hasUser"),o&&i.request("applet:userprofile:route"),s=e.get("applets"),a=0,u=s.length;a<u;a++)t=s[a],(null!=t?t.appname:void 0)&&(l="applet:"+t.appname+":route",i.request(l));if(i.request("mainpage:init",e),!r.history.started)return r.history.start()})},t.exports=l},52:function(t,e,n){var r,o,i,a,u,s,l,p,c=function(t,e){function n(){this.constructor=t}for(var r in e)d.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},d={}.hasOwnProperty;r=n(7),l=n(8),i=n(2),u=n(3),a=i.Radio.channel("global"),s=i.Radio.channel("messages"),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return c(e,t),e.prototype.copy_status="copy",e.prototype._add_models=function(t,e){return this.reset(),this.add(t),this.copy_status=e},e.prototype.copy=function(t){return this._add_models(t,"copy")},e.prototype.cut=function(t){return this._add_models(t,"cut")},e.prototype.paste=function(){var t;return t=this.models.slice(),this.reset(),t},e}(i.Collection),p=new o,a.reply("main:app:app-clipboard",function(){return p}),t.exports={AppClipboard:o}},53:function(t,e,n){var r,o,i,a,u=function(t,e){return function(){return t.apply(e,arguments)}},s=function(t,e){function n(){this.constructor=t}for(var r in e)l.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},l={}.hasOwnProperty;a=n(8),o=n(3),i=n(48),r=function(t){function e(){this.invalid=u(this.invalid,this),this.valid=u(this.valid,this),e.__super__.constructor.apply(this,arguments),this.listenTo(this,"render",this.hideActivityIndicator),this.listenTo(this,"render",this.prepareModel),this.listenTo(this,"save:form:success",this.success),this.listenTo(this,"save:form:failure",this.failure)}return s(e,t),e.prototype.delegateEvents=function(t){return this.ui=a.extend(this._baseUI(),a.result(this,"ui")),this.events=a.extend(this._baseEvents(),a.result(this,"events")),e.__super__.delegateEvents.call(this,t)},e.prototype.tagName="form",e.prototype._baseUI=function(){return{submit:'input[type="submit"]',activityIndicator:".spinner"}},e.prototype._baseEvents=function(){var t;return t={"change [data-validation]":this.validateField,"blur [data-validation]":this.validateField,"keyup [data-validation]":this.validateField},t["click "+this.ui.submit]=this.processForm,t},e.prototype.createModel=function(){throw new Error("implement #createModel in your FormView subclass to return a Backbone model")},e.prototype.prepareModel=function(){return this.model=this.createModel(),this.setupValidation()},e.prototype.validateField=function(t){var e,n;return e=$(t.target).attr("data-validation"),n=$(t.target).val(),this.model.preValidate(e,n)?this.invalid(this,e):this.valid(this,e)},e.prototype.processForm=function(t){return t.preventDefault(),this.showActivityIndicator(),this.updateModel(),this.saveModel()},e.prototype.updateModel=function(){throw new Error("implement #updateModel in your FormView subclass to update the attributes of @model")},e.prototype.saveModel=function(){var t;return t={success:function(t){return function(){return t.trigger("save:form:success",t.model)}}(this),error:function(t){return function(){return t.trigger("save:form:failure",t.model)}}(this)},this.model.save({},t)},e.prototype.success=function(t){return this.render(),this.onSuccess(t)},e.prototype.onSuccess=function(t){return null},e.prototype.failure=function(t){return this.hideActivityIndicator(),this.onFailure(t)},e.prototype.onFailure=function(t){return null},e.prototype.showActivityIndicator=function(){return this.ui.activityIndicator.show(),this.ui.submit.hide()},e.prototype.hideActivityIndicator=function(){return this.ui.activityIndicator.hide(),this.ui.submit.show()},e.prototype.setupValidation=function(){return Backbone.Validation.unbind(this),Backbone.Validation.bind(this,{valid:this.valid,invalid:this.invalid})},e.prototype.valid=function(t,e,n){return this.$("[data-validation="+e+"]").removeClass("invalid").addClass("valid")},e.prototype.invalid=function(t,e,n,r){return this.failure(this.model),this.$("[data-validation="+e+"]").removeClass("valid").addClass("invalid")},e}(Backbone.Marionette.View),t.exports=r},55:function(t,e,n){var r,o,i;o=n(4),i=o.renderable(function(t){var e;return e=t.name,o.ul("#user-menu.ctx-menu.nav.navbar-nav",function(){return o.li(".dropdown",function(){return o.a(".dropdown-toggle",{"data-toggle":"dropdown"},function(){return void 0===e?o.text("Guest"):o.text(e),o.b(".caret")}),o.ul(".dropdown-menu",function(){var n,r,i,a,u;if(void 0===e)return o.li(function(){return o.a({href:"#frontdoor/login"},"login")});if(o.li(function(){return o.a({href:"#profile"},"Profile Page")}),n=!1,void 0!==e&&(i=t.groups,void 0!==i))for(a=0,u=i.length;a<u;a++)r=i[a],"admin"===r.name&&(n=!0);return"admin"===t.name&&(n=!0),n&&o.li(function(){var t,e;return t="/admin",e=window.location.pathname,""===e.split(t)[0]&&(t="#"),o.a({href:t},"Administer Site")}),o.li(function(){return o.a({href:"/logout"},"Logout")})})})})}),r=o.renderable(function(t){return o.div(".btn-group-vertical",function(){var e,n,r,i,a;for(i=t.entries,a=[],n=0,r=i.length;n<r;n++)e=i[n],a.push(o.div(".btn.btn-default.sidebar-entry-button",{"button-url":e.url},function(){return o.text(e.name)}));return a})}),t.exports={user_menu:i,main_sidebar:r}},56:function(t,e,n){var r,o,i,a;a=n(4),o=a.renderable(function(t){var e;return e=t.level,"error"===e&&(e="danger"),a.div(".alert.alert-"+e,function(){return a.button(".close",{type:"button","aria-hidden":!0},function(){return a.raw("&times;")}),t.icon&&a.span(".glyphicon.glyphicon-"+t.icon),a.text(t.content)})}),i=a.renderable(function(t){var e;return e=t.level,"error"===e&&(e="danger"),a.div(".alert-dismissable.alert.alert-"+e,function(){return a.button(".close",{type:"button","data-dismiss":"alert","aria-hidden":!0},function(){return a.raw("&times;")}),a.text(t.content)})}),r=a.renderable(function(){return a.div("#ace-editor",{style:"position:relative;width:100%;height:24em;"})}),t.exports={message_box:o,message_box_dismissable:i,ace_editor_div:r}},57:function(t,e,n){var r,o,i,a,u,s,l,p;p=n(4),l=n(22),s=l.navbar_collapse_button,o=l.dropdown_toggle,r=p.renderable(function(t){return p.div(".container",function(){return p.div("#navbar-brand.navbar-header",function(){return p.button(".navbar-toggle",{type:"button","data-toggle":"collapse","data-target":".navbar-collapse"},function(){return p.span(".sr-only","Toggle Navigation"),p.span(".icon-bar"),p.span(".icon-bar"),p.span(".icon-bar")}),p.a(".navbar-brand",{href:t.brand.url},t.brand.name)}),p.div(".navbar-collapse.collapse",function(){return p.ul("#app-navbar.nav.navbar-nav",function(){var e,n,r,o,i;for(o=t.applets,i=[],n=0,r=o.length;n<r;n++)e=o[n],i.push(p.li({appname:e.appname},function(){return p.a({href:e.url},e.name)}));return i}),p.ul("#main-menu.nav.navbar-nav.navbar-left"),p.ul("#user-menu.nav.navbar-nav.navbar-right")})})}),u=p.renderable(function(t){return p.form("#form-search.navbar-form.navbar-right",{role:"search",method:"post",action:""+t.navbarSearchAction},function(){return p.div(".form-group",function(){return p.input(".form-control",{name:"search-term",type:"search",placeholder:"Search..."})}),p.button(".btn.btn-default",{type:"submit",name:"search-submit",value:"search",style:"display: none;"},function(){return p.raw("&#8594")})})}),a=p.renderable(function(t){return p.div("."+(t.container||"container"),function(){return p.div(".navbar-header",function(){return s("navbar-view-collapse"),p.a(".navbar-brand",{href:t.brand.url},t.brand.name)}),p.div("#navbar-view-collapse.collapse.navbar-collapse",function(){return p.ul(".nav.navbar-nav",function(){var e,n,r,o,i;for(o=t.applets,i=[],n=0,r=o.length;n<r;n++)e=o[n],i.push(p.li({appname:e.appname},function(){return p.a({href:e.url},e.name)}));return i}),p.ul("#user-menu.nav.navbar-nav.navbar-right"),p.div("#form-search-container")})})}),i=p.renderable(function(t){return p.nav("#navbar-view.navbar.navbar-static-top.navbar-default",{xmlns:"http://www.w3.org/1999/xhtml","xml:lang":"en",role:"navigation"},function(){return a(t)})}),t.exports={nav_pt_search:u,nav_pt:i,BootstrapNavBarTemplate:r}},87:function(t,e,n){var r,o,i=function(t,e){return function(){return t.apply(e,arguments)}},a=function(t,e){function n(){this.constructor=t}for(var r in e)u.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},u={}.hasOwnProperty;o=n(53),r=function(t){function e(){return this.invalid=i(this.invalid,this),this.valid=i(this.valid,this),e.__super__.constructor.apply(this,arguments)}return a(e,t),e.prototype.valid=function(t,e,n){return this.$("[data-validation="+e+"]").parent().removeClass("has-error").addClass("has-success")},e.prototype.invalid=function(t,e,n,r){return this.failure(this.model),this.$("[data-validation="+e+"]").parent().removeClass("has-success").addClass("has-error")},e}(o),t.exports=r},114:function(t,e,n){var r,o,i,a,u,s,l,p=function(t,e){function n(){this.constructor=t}for(var r in e)c.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},c={}.hasOwnProperty;r=n(2),o=n(3),l=n(10),i=l.create_model,a=l.get_model,s=function(t,e){var n,o,i,a;return a=o=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.urlRoot=e,n}(r.Model),i=n=function(t){function n(){return n.__super__.constructor.apply(this,arguments)}return p(n,t),n.prototype.model=a,n.prototype.url=e,n}(r.Model),{modelClass:a,collectionClass:i}},u=function(t,e,n,r){var o;return o=new r,t.reply(e+"-collection",function(){return o}),t.reply("new-"+e,function(){return new n}),t.reply("add-"+e,function(t){return i(o(t))}),t.reply("get-"+e,function(t){return a(o,t)}),t.reply(e+"-modelClass",function(){return n}),t.reply(e+"-collectionClass",function(){return r})},t.exports={make_dbclasses:s,make_dbchannel:u}},115:function(t,e,n){var r,o,i,a,u,s,l,p,c,d,f,_,v=function(t,e){function n(){this.constructor=t}for(var r in e)h.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},h={}.hasOwnProperty;r=n(2),l=n(3),_=n(4),d=n(10).navigate_to_url,f=n(14).show_modal,c=n(22).modal_close_button,s=r.Radio.channel("global"),p=r.Radio.channel("messages"),u=_.renderable(function(t){return _.div(".modal-dialog",function(){return _.div(".modal-content",function(){return _.h3("Do you really want to delete "+t.name+"?"),_.div(".modal-body",function(){return _.div("#selected-children")}),_.div(".modal-footer",function(){return _.ul(".list-inline",function(){var t;return t="btn.btn-default.btn-sm",_.li("#confirm-delete-button",function(){return c("OK","check")}),_.li("#cancel-delete-button",function(){return c("Cancel")})})})})})}),a=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return v(e,t),e.prototype.template=u,e.prototype.ui={confirm_delete:"#confirm-delete-button",cancel_button:"#cancel-delete-button"},e.prototype.events=function(){return{"click @ui.confirm_delete":"confirm_delete"}},e.prototype.confirm_delete=function(){var t,e;return t=this.model.get("name"),e=this.model.destroy(),e.done(function(e){return function(){return p.request("success",t+" deleted.")}}(this)),e.fail(function(e){return function(){return p.request("danger",t+" NOT deleted.")}}(this))},e}(r.Marionette.View),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return v(e,t),e.prototype.ui={edit_item:".edit-item",delete_item:".delete-item",item:".list-item"},e.prototype.events=function(){return{"click @ui.edit_item":"edit_item","click @ui.delete_item":"delete_item"}},e.prototype.edit_item=function(){return d("#"+this.route_name+"/"+this.item_type+"s/edit/"+this.model.id)},e.prototype.delete_item=function(){var t;return t=new a({model:this.model}),f(t,!0)},e}(r.Marionette.View),i=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return v(e,t),e.prototype.childViewContainer="#"+e.item_type+"-container",e.prototype.ui=function(){return{make_new_item:"#new-"+this.item_type}},e.prototype.events=function(){return{"click @ui.make_new_item":"make_new_item"}},e.prototype._show_modal=function(t,e){var n;return null==e&&(e=!1),n=s.request("main:app:get-region","modal"),n.backdrop=e,n.show(t)},e.prototype.make_new_item=function(){return d("#"+this.route_name+"/"+this.item_type+"s/new")},e}(r.Marionette.CompositeView),t.exports={BaseItemView:o,BaseListView:i}},117:function(t,e,n){var r,o,i,a,u,s,l,p=function(t,e){function n(){this.constructor=t}for(var r in e)c.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},c={}.hasOwnProperty;r=n(2),a=n(3),l=n(4),u=n(10).navigate_to_url,i=r.Radio.channel("bumblr"),s=l.renderable(function(t){return l.div(".sidebar-menu.btn-group-vertical",function(){var e,n,r,o,i;for(o=t.entries,i=[],n=0,r=o.length;n<r;n++)e=o[n],i.push(l.button(".sidebar-entry-button.btn.btn-default",{"button-url":e.url},function(){return l.text(e.name)}));return i})}),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return p(e,t),e.prototype.template=s,e.prototype.events={"click .sidebar-entry-button":"sidebar_button_pressed"},e.prototype.sidebar_button_pressed=function(t){var e;return e=t.currentTarget.getAttribute("button-url"),u(e)},e}(r.Marionette.View),t.exports=o},118:function(t,e,n){var r,o,i,a,u,s;s=n(4),u=n(25),a=n(24).form_group_input_div,i=n(10).capitalize,r=function(t,e){return s.renderable(function(n){var r;return r=".btn.btn-default.btn-xs",s.li(".list-group-item."+t+"-item",function(){return s.span(function(){return s.a({href:"#"+e+"/"+t+"s/view/"+n.id},n.name)}),s.div(".btn-group.pull-right",function(){return s.button(".edit-item."+r+".btn-info.fa.fa-edit","edit"),s.button(".delete-item."+r+".btn-danger.fa.fa-close","delete")})})})},o=function(t){return s.renderable(function(e){return s.div(".listview-header",function(){return s.text(i(t))}),s.button("#new-"+t+".btn.btn-default",function(){return"Add New "+i(t)}),s.hr(),s.ul("#"+t+"-container.list-group")})},t.exports={base_item_template:r,base_list_template:o}},119:function(t,e,n){var r,o,i,a,u,s,l=function(t,e){function n(){this.constructor=t}for(var r in e)p.call(e,r)&&(t[r]=e[r]);return n.prototype=e.prototype,t.prototype=new n,t.__super__=e.prototype,t},p={}.hasOwnProperty;r=n(2),i=r.Radio.channel("global"),a=r.Radio.channel("messages"),u=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e}(r.Model),o=function(t){function e(){return e.__super__.constructor.apply(this,arguments)}return l(e,t),e}(u),s=function(t){var e;return e=new o,e.url=t,e},i.reply("create-current-user-object",function(t){var e;return e=s(t),i.reply("current-user",function(){return e}),i.reply("update-user-config",function(t){var n;return e.set("config",t),n=e.save(),n.done(function(t){return function(){return e}}(this)),n.fail(function(t){return function(){return a.request("danger","failed to update user config!")}}(this))}),e}),t.exports={User:u,CurrentUser:o}}});