
        private byte[] GetLegalKey()
        {
            string keyTmp = m_Key;

            var randomKeySize = size / 8;
            // 一个字符转成1个字节也就是8位，256/8=32，如果使用其他密钥长度，要修改成对应的值
            if (keyTmp.Length < randomKeySize)
            {
                keyTmp += c_RandomKey.Substring(0, randomKeySize - keyTmp.Length);
            }
            else if (keyTmp.Length > randomKeySize)
            {
                keyTmp = keyTmp.Substring(0, randomKeySize);
            }

            // 转换字符串到Byte数组
            // 此处建议使用ASCIIEncoding.ASCII而不要使用ASCIIEncoding.Default或者Encoding.GetEncoding( "GB2312" )
            // 来获取编码。否则的话，当密钥字串包含中文，所获得的数组长度可能会不符合密钥长度要求。当然你也可以做
            // 相应的处理来解决这个问题。
            return Encoding.ASCII.GetBytes(keyTmp);

        }

        public string Encrypting(string Source)
        {
            // 当然你也可以使用以下语句来确保支持中文
            // byte[] bytIn = Encoding.GetEncoding( "GB2312" ).GetBytes( Source );
            byte[] bytIn = Encoding.UTF8.GetBytes(Source);


            MemoryStream ms = new MemoryStream();

            byte[] bytKey = GetLegalKey();

            m_Rijndael.Key = bytKey;
            m_Rijndael.IV = bytKey;

            ICryptoTransform encrypto = m_Rijndael.CreateEncryptor();
            CryptoStream cs = new CryptoStream(ms, encrypto, CryptoStreamMode.Write);

            cs.Write(bytIn, 0, bytIn.Length);
            cs.FlushFinalBlock();

            byte[] bytOut = ms.ToArray();

            cs.Clear();
            cs.Close();

            return Convert.ToBase64String(bytOut, 0, bytOut.Length);
        }

        public string Decrypting(string Source)
        {
            byte[] bytIn = Convert.FromBase64String(Source);

            MemoryStream ms = new MemoryStream(bytIn);

            byte[] bytKey = GetLegalKey();

            m_Rijndael.Key = bytKey;
            m_Rijndael.IV = bytKey;

            ICryptoTransform encrypto = m_Rijndael.CreateDecryptor();
            CryptoStream cs = new CryptoStream(ms, encrypto, CryptoStreamMode.Read);

            byte[] bytOut = new byte[bytIn.Length];
            cs.Read(bytOut, 0, bytOut.Length);
            cs.Clear();
            cs.Close();

            // return Encoding.GetEncoding( "GB2312" ).GetString( bytOut ).TrimEnd( new char[] { '\0' } );
            return Encoding.UTF8.GetString(bytOut).TrimEnd(new char[] { '\0' });
        }
