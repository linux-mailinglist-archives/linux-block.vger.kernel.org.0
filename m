Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5785217C697
	for <lists+linux-block@lfdr.de>; Fri,  6 Mar 2020 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFT4y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Mar 2020 14:56:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27830 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCFT4x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Mar 2020 14:56:53 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026JuJ0n026478;
        Fri, 6 Mar 2020 11:56:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UZIiYpbkzisgKEvmMjpBtfK+PJI2yPegiriUOafbbHQ=;
 b=qbpGsJbmFvP0/kpgu03FlIsvGSgN6Fhqf0t1CQFJq34KOZVO0lGYtfxeY9+JIar2L0Vb
 w2RJEeicgZTSn1qn2745FBrDRfEJDZNtdtUqDh0cP2/D4qOZvUd7oTmJtOJV5MYViMGW
 3YVl8Cs2UYPUah88BWmh7wwgYcjzGQT371w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2ykrv7he6a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Mar 2020 11:56:48 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 6 Mar 2020 11:56:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHhV99NMxBPoGEEEjUotAA5OYTVnGO34vKStq7kcVr7Csdqy+/LWS/6NSxsO0//7wkEPtH4gTimV1F8NEcTrfJbnScnmFw+04DLcbRGhsHD+iqiMQinRoq/HmZQZMx+rKkRG1a0HnuvL4QQPP9m0qaZzBYGK7gP+oqaODQkMfFA4hsOvhvZ8/gLJBNo07fqy11Lvigj/0i/YEpw2xDw1GHXdrTNEc7W0ZlCG1dDG1cmid7eYpTbn8P8z+q60GHTLdKh/RlVSGi2NGtQlFP8lIss40Qi2/tN6kErwuOMl5GiKKPxoojMIx0NnIaKUHRyNWKDU7ZpSY0eMESou9kXABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZIiYpbkzisgKEvmMjpBtfK+PJI2yPegiriUOafbbHQ=;
 b=LbCMx5/pY9iWDtDgGxwtSt9naN6IBwsE6zD7/p6rGYYDKjM+qcOluM6PF+vJChA0NnICE5NVDBIBSn342Ldlem1uqzEFB/i7QA9dbV0MkhWylMqnuWXDg8Jr8b7JH0b0GY/YYpBR50jafJKujgj7Zs5pc42lgQd//b9cxdS5IVbQimpw9PpnmK2Rw6PJCbwNS93W09cBzOyLysC0S6z5h6ATMOUhO+z6Yy2LOwMqeDwxzDGVRs0zoa2dlYN1++Fa1AF4BQmlD3mLFQnuQGHzDcXoWjGFsqM/mRr9Q6iqkFnYgfCC8ncXsDh27hWza9XKx5zd7ZiXr8HGqKXKqYL6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZIiYpbkzisgKEvmMjpBtfK+PJI2yPegiriUOafbbHQ=;
 b=Je3MDsLx9hyYL+f55IAB7/F4vOsII2mrSfjngnKGlMCyP2kCSUaS/zrIbSeuUx27Xz5nKL7iTeS1vOTk8jr+AE1hS5wx+YvlvyvPz0Z76AON2VyZLK+sc0Gg9GnU2ar87/o7b/jROvVgWvWlBiv2P6dcE1eqBMwF6PJqAp9Wd1Q=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (2603:10b6:805:22::25)
 by SN6PR15MB2462.namprd15.prod.outlook.com (2603:10b6:805:17::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 6 Mar
 2020 19:56:31 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::1d55:c224:e49f:ebc1]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::1d55:c224:e49f:ebc1%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 19:56:31 +0000
From:   "Chris Mason" <clm@fb.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-block@vger.kernel.org>
Subject: Re: [LSFMMBPF TOPIC] long live LFSMMBPF
Date:   Fri, 06 Mar 2020 14:56:28 -0500
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <C20983BD-EBCF-4B29-B49B-BAD164F83943@fb.com>
In-Reply-To: <1583523705.3653.94.camel@HansenPartnership.com>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <76B62C4B-6ECB-482B-BF7D-95F42E43E7EB@fb.com>
 <1583523705.3653.94.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.115.171] (2620:10d:c091:480::65ce) by MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 19:56:30 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::65ce]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3140328f-2a68-49ab-4187-08d7c208770d
X-MS-TrafficTypeDiagnostic: SN6PR15MB2462:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2462F11A348111D427B905F2D3E30@SN6PR15MB2462.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(81156014)(81166006)(36756003)(66476007)(66946007)(5660300002)(4326008)(6916009)(8676002)(66556008)(316002)(8936002)(52116002)(33656002)(86362001)(7416002)(6486002)(478600001)(2906002)(16526019)(2616005)(54906003)(186003)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2462;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNgnV4xV/Q78Z4x2U+9QRWhCZJF1CiuLzuIHswSdnOEBkfCyUdNXrLUizFb4SGoys2IryyAZaKJVtlEKVFw4Oq+4IuK0xItdpgVPe0my/g65dAI6flgzQhM2W0oznMgdCE8j6VFsJtTnjhXyqgAjy8QHO/7hsvyaul6NMctmflMZMk4AUcU8+ifmX7Qz7CTCi7dZ9T4nL3mrygCwjF/ijiQ/JZFbgdBceyVNCeCwxBsRxJPwctdupF6cxKOpq7bEYIIvC0FL+erob2ivpwxwp12Pj8VWUY4DuuioYZC1iypIeaw6CDVgILIonxYo2rPkEgcH68l+qmo9qpVxmgz89Q8p3me2lrTffzrRCO01G/RMi6CddzOSRDg4sQ5BkArUDoON+SlfddsTEAnc248wx1EPfn1bXbPaYxZYLFb7YsuEOZvsURUz2IDce4AnYA+9
X-MS-Exchange-AntiSpam-MessageData: vxZ1eOmd0yD0PL602fveHRr3d8ZYV4QJ71B3KSijyCpnQwIGC6Zy4qWPodu5fESKZWX2cLDqdU9opZ6QsvTxGYqHwoq6YFkzrYPsLlQyMsXl10uJWUCVWUlwPXbsjN+t1EHZDsMPTAz1A9QSsMqR92fkXKVHKk9ROkNZ3mvUyMY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3140328f-2a68-49ab-4187-08d7c208770d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 19:56:31.0777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsZj6uSlx5Y/uTvxDEQKGKwi42xTPR/VcxF0SDl5gc5toeUf90Ze+sb8vNpqICKD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2462
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_07:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011
 mlxlogscore=805 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060120
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6 Mar 2020, at 14:41, James Bottomley wrote:

> On Fri, 2020-03-06 at 14:27 -0500, Chris Mason wrote:
>> On 6 Mar 2020, at 9:35, Josef Bacik wrote:
> [...]
>>> 4) Planning becomes much simpler.  I've organized miniconf's at
>>> plumbers before, it is far simpler than LSFMMBPF.  You only have
>>> to worry about one thing, is this presentation useful.  I no longer
>>> have to worry about am I inviting the right people, do we have
>>> enough money to cover the space.  Is there enough space for
>>> everybody?  Etc.
>>
>> We’ve talked about working closely with KS, Plumbers and the
>> Linuxfoundation to make a big picture map of the content and
>> frequency  for these confs.
>
> And, lest anyone think we all operate in isolation, we do get together
> periodically to discuss venues, selection and combination.  The last
> big in-person meeting on this topic was at Plumbers in Vancouver in
> 2019, where we had Plumbers, KS/MS, LSF/MM and the LF conference 
> people
> all represented.

Yeah, there’s a lot of cross-over between all the PCs, so we have lots 
of chances to talk it through.

>
>>   I’m sure Angela is having a busy few weeks, but lets work with 
>> her
>> to schedule this and talk it through.  OSS is a good fit  in terms of
>> being flexible enough to fit us in, hopefully we can make  that work.
>
> And, for everyone who gave us feedback in the Plumbers surveys that 
> co-
> locating with a big conference is *not* what you want because of
> various problems like hallway track disruptions due to other 
> conference
> traffic and simply the difficulty of finding people, the current model
> under consideration is one conference organization (the LF) but two
> separate venues, sort of like OpenStack used to do for their big
> conference and design summit to minimize disruption and increase
> developer focus.
>

Agreed, but I do like the idea of doing the plenary in the bigger 
conference sessions.

-chris
