Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67F782D42
	for <lists+linux-block@lfdr.de>; Mon, 21 Aug 2023 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjHUP2b (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Aug 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHUP2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2023 11:28:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEFCF3;
        Mon, 21 Aug 2023 08:28:27 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFBkBe019665;
        Mon, 21 Aug 2023 15:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=4BCPF28Yejo0utjXOqmX/YVNPMuvsZagjVSJiXGOnLQ=;
 b=WxnNvJhpbwxp2ogAm93+C01Utn4OERDWz7Jm2zdduYIIpDeIwJhz/ob0nCSwwm4dMxsg
 6LPv4r9/d3TE8O7JcygXVQaeA33y65RYGBEIO0oWiyHVRs5lYSuuI6opjysleDslB85d
 2j2ZreyGOo6O6U/X9Lo1zT4CN6HaHvpSJLYFn/Snf+FYhRPdI5hmymS9ALqwqTNYLZQZ
 46We58Rmgg5S9g+Lx9puGsk8dpCm1rlm0VIJAPSbyt6RQA3hWnxpyIa30oy1eqeV4wms
 7FD57L1MQA/jDl1zQ4hs77b/U7ryiqvurKYKy/syzHVjo9G86CuXn5LfaXK2dW4t7JrN 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sm9ww9ek9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 15:27:57 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LFLFSS020002;
        Mon, 21 Aug 2023 15:27:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sm9ww9ek0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 15:27:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFKWcY018452;
        Mon, 21 Aug 2023 15:26:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sk82smda7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 15:26:56 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37LFQt8t23593478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 15:26:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E47ED5805A;
        Mon, 21 Aug 2023 15:26:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6BA5803F;
        Mon, 21 Aug 2023 15:26:55 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.60.97])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Aug 2023 15:26:55 +0000 (GMT)
Message-ID: <a232e46bb7b364a6ef7d77aef853d0ddda4e3f2a.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/3 RESEND] sed-opal: keyrings, discovery, revert,
 key store
From:   Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reply-To: gjoyce@linux.vnet.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, axboe@kernel.dk, akpm@linux-foundation.org,
        keyrings@vger.kernel.org, okozina@redhat.com, dkeefe@redhat.com
Date:   Mon, 21 Aug 2023 10:26:55 -0500
In-Reply-To: <CUU9DZ1YEZVF.16X1CD7ES1RXD@suppilovahvero>
References: <20230721211534.3437070-1-gjoyce@linux.vnet.ibm.com>
         <46cda90a12da4639d1e65ce82ae342df05b7afc2.camel@linux.vnet.ibm.com>
         <CUU9DZ1YEZVF.16X1CD7ES1RXD@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RcdATUjtltTdXnCgWqPfjVO9qHvDevHU
X-Proofpoint-ORIG-GUID: 9nD2g9hjl3NGhAG-uoQGc4xhDMv_CjeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_03,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 spamscore=0 malwarescore=0 mlxlogscore=984 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2023-08-16 at 23:41 +0300, Jarkko Sakkinen wrote:
> On Wed Aug 16, 2023 at 10:45 PM EEST, Greg Joyce wrote:
> > It's been almost 4 weeks since the last resend and there haven't
> > been
> > any comments. Is there anything that needs to be changed for
> > acceptance?
> > 
> > Thanks for your input.
> > 
> > Greg
> > 
> > On Fri, 2023-07-21 at 16:15 -0500, gjoyce@linux.vnet.ibm.com wrote:
> > > From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> > > 
> > > This patchset has gone through numerous rounds of review and
> > > all comments/suggetions have been addressed. The reviews have
> > > covered all relevant areas including reviews by block and keyring
> > > developers as well as the SED Opal maintainer. The last
> > > patchset submission has not solicited any responses in the
> > > six weeks since it was last distributed. The changes are
> > > generally useful and ready for inclusion.
> > > 
> > > TCG SED Opal is a specification from The Trusted Computing Group
> > > that allows self encrypting storage devices (SED) to be locked at
> > > power on and require an authentication key to unlock the drive.
> > > 
> > > The current SED Opal implementation in the block driver
> > > requires that authentication keys be provided in an ioctl
> > > so that they can be presented to the underlying SED
> > > capable drive. Currently, the key is typically entered by
> > > a user with an application like sedutil or sedcli. While
> > > this process works, it does not lend itself to automation
> > > like unlock by a udev rule.
> > > 
> > > The SED block driver has been extended so it can alternatively
> > > obtain a key from a sed-opal kernel keyring. The SED ioctls
> > > will indicate the source of the key, either directly in the
> > > ioctl data or from the keyring.
> > > 
> > > Two new SED ioctls have also been added. These are:
> > >   1) IOC_OPAL_REVERT_LSP to revert LSP state
> > >   2) IOC_OPAL_DISCOVERY to discover drive capabilities/state
> > > 
> > > change log v5:
> > >         - rebase to for-6.5/block
> > > 
> > > change log v4:
> > >         - rebase to 6.3-rc7
> > >         - replaced "255" magic number with U8_MAX
> > > 
> > > change log:
> > >         - rebase to 6.x
> > >         - added latest reviews
> > >         - removed platform functions for persistent key storage
> > >         - replaced key update logic with key_create_or_update()
> > >         - minor bracing and padding changes
> > >         - add error returns
> > >         - opal_key structure is application provided but kernel
> > >           verified
> > >         - added brief description of TCG SED Opal
> > > 
> > > 
> > > Greg Joyce (3):
> > >   block: sed-opal: Implement IOC_OPAL_DISCOVERY
> > >   block: sed-opal: Implement IOC_OPAL_REVERT_LSP
> > >   block: sed-opal: keyring support for SED keys
> > > 
> > >  block/Kconfig                 |   2 +
> > >  block/opal_proto.h            |   4 +
> > >  block/sed-opal.c              | 252
> > > +++++++++++++++++++++++++++++++++-
> > >  include/linux/sed-opal.h      |   5 +
> > >  include/uapi/linux/sed-opal.h |  25 +++-
> > >  5 files changed, 282 insertions(+), 6 deletions(-)
> > > 
> > > 
> > > base-commit: 1341c7d2ccf42ed91aea80b8579d35bc1ea381e2
> 
> I can give because it looks good to me to all patches:
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> ... but should not probably go to my tree.
> 
> BR, Jarkko

Thanks for the ack Jarkko. Any thoughts on which tree it should go to?

Greg

