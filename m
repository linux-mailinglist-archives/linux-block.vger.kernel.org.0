Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD763F717
	for <lists+linux-block@lfdr.de>; Thu,  1 Dec 2022 19:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLASEW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Dec 2022 13:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiLASEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 13:04:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC4578DF;
        Thu,  1 Dec 2022 10:04:18 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1GSD2Y029790;
        Thu, 1 Dec 2022 18:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=p5B/+ZDx1TLVqFIdQM4sL1zKOfhAk6OvvdoYRiuC1Hg=;
 b=PN6Mm0LRpdFgstVz6uIdzcRPnY1qFwz6UkeZpnNcBK2oPv9tjJUo6pQeS12T8gg0Uhyo
 jgXn4UwdO6vLSqXru41ubOOq5DEC0aligpUBD0kI9+qkZOk0OCtYZG8No8UTZqNFBy+u
 4ExiZ7kmUN7wgpjWrAZQ+mcRm7j1+/8t4Xuc23D9vxSbjroGUYzcSdhpgtP9qDp94ZKE
 xqV4HHBSEP6lUvhWr5cGOj/0JZSqxOVI8/4etFCTrVOpgRjrpvaXH26WfFZTHdjRagxp
 ijcPOVN298Tl7KlUfPTqqmz7BbjrBzdnB8HkCcPm5DrdM2hF2xxbrXFSg6rwbgvb9JSk bw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ytnakfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 18:04:01 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B1HpTFE005976;
        Thu, 1 Dec 2022 18:03:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma05wdc.us.ibm.com with ESMTP id 3m3t720ea2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 18:03:59 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B1I3wp451249624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Dec 2022 18:03:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B474C58052;
        Thu,  1 Dec 2022 18:03:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A17C658056;
        Thu,  1 Dec 2022 18:03:57 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.160.99.100])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  1 Dec 2022 18:03:57 +0000 (GMT)
Message-ID: <ed32cbc546383085bc8c00d913a53059831b2cfc.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] block: sed-opal: keyring support for SED keys
From:   Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reply-To: gjoyce@linux.vnet.ibm.com
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        keyrings@vger.kernel.org
Date:   Thu, 01 Dec 2022 12:03:57 -0600
In-Reply-To: <c78edd60-b6ae-6ec0-9ce4-73b9a92b9b32@suse.de>
References: <20221129232506.3735672-1-gjoyce@linux.vnet.ibm.com>
         <20221129232506.3735672-4-gjoyce@linux.vnet.ibm.com>
         <c78edd60-b6ae-6ec0-9ce4-73b9a92b9b32@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y9BkP77Xy5IeV2cUZqcZboy3e9BggQjr
X-Proofpoint-GUID: y9BkP77Xy5IeV2cUZqcZboy3e9BggQjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_12,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2022-11-30 at 08:00 +0100, Hannes Reinecke wrote:
> On 11/30/22 00:25, gjoyce@linux.vnet.ibm.com wrote:
> > From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> > 
> > Extend the SED block driver so it can alternatively
> > obtain a key from a sed-opal kernel keyring. The SED
> > ioctls will indicate the source of the key, either
> > directly in the ioctl data or from the keyring.
> > 
> > This allows the use of SED commands in scripts such as
> > udev scripts so that drives may be automatically unlocked
> > as they become available.
> > 
> > Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> > Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> > ---
> >   block/Kconfig                 |   1 +
> >   block/sed-opal.c              | 174
> > +++++++++++++++++++++++++++++++++-
> >   include/linux/sed-opal.h      |   3 +
> >   include/uapi/linux/sed-opal.h |   8 +-
> >   4 files changed, 183 insertions(+), 3 deletions(-)
> >  
> > +	ret = opal_get_key(dev, &opal_lrs->session.opal_key);
> > +	if (ret)
> > +		return ret;
> >   	mutex_lock(&dev->dev_lock);
> >   	setup_opal_dev(dev);
> >   	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
> > @@ -2622,6 +2759,14 @@ static int opal_set_new_pw(struct opal_dev
> > *dev, struct opal_new_pw *opal_pw)
> >   	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
> >   	mutex_unlock(&dev->dev_lock);
> >   
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* update keyring with new password */
> > +	ret = update_sed_opal_key(OPAL_AUTH_KEY,
> > +				  opal_pw->new_user_pw.opal_key.key,
> > +				  opal_pw-
> > >new_user_pw.opal_key.key_len);
> > +
> >   	return ret;
> >   }
> >   
> What about key revocation?
> You only allow to set a new key, but what happens with the old ones?

My understanding was that key_create_or_update() would not allow
duplicates so there shouldn't be old ones. Is that incorrect?

> 
> > +static int __init sed_opal_init(void)
> > +{
> > +	struct key *kr;
> > +
> > +	kr = keyring_alloc(".sed_opal",
> > +			   GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> > current_cred(),
> > +			   (KEY_POS_ALL & ~KEY_POS_SETATTR) |
> > KEY_USR_VIEW |
> > +			   KEY_USR_READ | KEY_USR_SEARCH |
> > KEY_USR_WRITE,
> > +			   KEY_ALLOC_NOT_IN_QUOTA,
> > +			   NULL, NULL);
> > +	if (IS_ERR(kr))
> > +		return PTR_ERR(kr);
> > +
> > +	sed_opal_keyring = kr;
> > +
> > +	return 0;
> > +}
> > +late_initcall(sed_opal_init);
> 
> Shouldn't you free the keyring on exit?

The SED Opal driver is part of the block driver and does not build as a
module so it will not exit. I had looked at "blacklist" as an example
and saw that it allocated but did not free its keyring.

> Cheers,
> 
> Hannes

Thanks for the comments on the keyring. I'm not very familiar with the
keyring code, so I'd appreciate suggestions on code changes if any are
needed for your two comments.

-Greg

