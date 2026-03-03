using System;

namespace Models.Admin.System
{
    /// <summary>管理员信息</summary>
    [Serializable]
    public class ManagerInfo
    {
        #region Model

        private string _table = "admin_per_manager";

        private int _id;
        private string _sole;
        private string _organsole;
        private string _relatedsole;
        private string _type;
        private string _name;
        private string _uid;
        private string _pass;
        private string _iconurl;
        private string _provincessole;
        private string _citysole;
        private string _cityname;
        private string _areasole;
        private string _regip;
        private string _regaddress;
        private string _allowip;
        private string _allowmac;
        private string _allowdate;
        private string _popedom;
        private string _groups;
        private int? _islogin;
        private int? _isaudit;
        private int? _isused;
        private int? _logincount;
        private string _loginlastdate;
        private string _createsole;
        private string _createdate;
        private string _note;

        /// <summary></summary>
        public string Table { set { _table = value; } get { return _table; } }

        /// <summary>id</summary>
        public int Id { set { _id = value; } get { return _id; } }
        /// <summary>唯一编号</summary>
        public string Sole { set { _sole = value; } get { return _sole; } }
        /// <summary>机构编号</summary>
        public string OrganSole { set { _organsole = value; } get { return _organsole; } }
        /// <summary>关联编号</summary>
        public string RelatedSole { set { _relatedsole = value; } get { return _relatedsole; } }
        /// <summary>类型</summary>
        public string Type { set { _type = value; } get { return _type; } }
        /// <summary>名称</summary>
        public string Name { set { _name = value; } get { return _name; } }
        /// <summary>登录名</summary>
        public string Uid { set { _uid = value; } get { return _uid; } }
        /// <summary>密码</summary>
        public string Pass { set { _pass = value; } get { return _pass; } }
        /// <summary>头像</summary>
        public string IconURL { set { _iconurl = value; } get { return _iconurl; } }
        /// <summary>省份编号</summary>
        public string ProvincesSole { set { _provincessole = value; } get { return _provincessole; } }
        /// <summary>城市编号</summary>
        public string CitySole { set { _citysole = value; } get { return _citysole; } }
        /// <summary>城市名称</summary>
        public string CityName { set { _cityname = value; } get { return _cityname; } }
        /// <summary>区县编号</summary>
        public string AreaSole { set { _areasole = value; } get { return _areasole; } }
        /// <summary>注册ip</summary>
        public string RegIp { set { _regip = value; } get { return _regip; } }
        /// <summary>注册地址</summary>
        public string RegAddress { set { _regaddress = value; } get { return _regaddress; } }
        /// <summary>允许登录ip</summary>
        public string AllowIp { set { _allowip = value; } get { return _allowip; } }
        /// <summary>允许登录mac</summary>
        public string AllowMac { set { _allowmac = value; } get { return _allowmac; } }
        /// <summary>过期时间</summary>
        public string AllowDate { set { _allowdate = value; } get { return _allowdate; } }
        /// <summary>操作等级</summary>
        public string Popedom { set { _popedom = value; } get { return _popedom; } }
        /// <summary>操作分组</summary>
        public string Groups { set { _groups = value; } get { return _groups; } }
        /// <summary>是否登录（当前登录状态）</summary>
        public int? IsLogin { set { _islogin = value; } get { return _islogin; } }
        /// <summary>是否审核</summary>
        public int? IsAudit { set { _isaudit = value; } get { return _isaudit; } }
        /// <summary>是否使用</summary>
        public int? IsUsed { set { _isused = value; } get { return _isused; } }
        /// <summary>登陆次数</summary>
        public int? LoginCount { set { _logincount = value; } get { return _logincount; } }
        /// <summary>最后登录（最后心跳时间）</summary>
        public string LoginLastDate { set { _loginlastdate = value; } get { return _loginlastdate; } }
        /// <summary>添加人</summary>
        public string CreateSole { set { _createsole = value; } get { return _createsole; } }
        /// <summary>添加时间</summary>
        public string CreateDate { set { _createdate = value; } get { return _createdate; } }
        /// <summary>备注</summary>
        public string Note { set { _note = value; } get { return _note; } }

        #endregion Model
    }
}