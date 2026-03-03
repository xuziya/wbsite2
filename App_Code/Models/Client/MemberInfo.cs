using System;

namespace Models.Client
{
    /// <summary>管理员信息</summary>
    [Serializable]
    public class MemberInfo
    {
        #region Model

        private string _table = "student_info";

        private int _id;
        private string _sole;
        private string _organSole;
        private string _type;

        private string _name;
        private string _sex;
        private string _age;
        private string _post;
        private string _duties;
        private string _mobile;
        private string _uid;
        private string _pass;
        private string _savePath1;
        private string _savePath2;

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
        public string OrganSole { set { _organSole = value; } get { return _organSole; } }
        /// <summary>类型</summary>
        public string Type { set { _type = value; } get { return _type; } }
        
        /// <summary>名称</summary>
        public string Name { set { _name = value; } get { return _name; } }
        /// <summary>性别</summary>
        public string Sex { set { _sex = value; } get { return _sex; } }
        /// <summary>年龄</summary>
        public string Age { set { _age = value; } get { return _age; } }
        /// <summary>岗位</summary>
        public string Post { set { _post = value; } get { return _post; } }
        /// <summary>职务</summary>
        public string Duties { set { _duties = value; } get { return _duties; } }
        /// <summary>联系电话</summary>
        public string Mobile { set { _mobile = value; } get { return _mobile; } }
        /// <summary>用户名</summary>
        public string Uid { set { _uid = value; } get { return _uid; } }
        /// <summary>密码</summary>
        public string Pass { set { _pass = value; } get { return _pass; } }
        /// <summary>头像1</summary>
        public string SavePath1 { set { _savePath1 = value; } get { return _savePath1; } }
        /// <summary>头像2</summary>
        public string SavePath2 { set { _savePath2 = value; } get { return _savePath2; } }

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