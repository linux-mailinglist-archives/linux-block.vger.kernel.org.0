Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C2641415
	for <lists+linux-block@lfdr.de>; Sat,  3 Dec 2022 05:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLCETe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Dec 2022 23:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiLCETd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 23:19:33 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D76E988C
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 20:19:32 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h10so7473805ljk.11
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 20:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccD2JrUqoo8dGTQE9lIA6Ic8NF4n65yiBkZdSFL8aqk=;
        b=CABa0c6Z8GB68LpfcT6ifNmMsRl7DojSt4Fz1SE0rQ5YTWctV66UCulvr3VgqKgoPM
         C8XUke796Bj/HUETpCMj69/cGSEj0lU8xCpBLAHjeANAQ07/qld/hw+W732EEmu5Ghtw
         ob24fAgs3ragUTh6oQvWZHvxqpi01iWPHK9X+81oVWSvCBtue4daxQkaz9pdB1B0Qc3z
         PYnL5RsoKUmqc9z+sum4t4NTPJwft9tylToWPiTLf3kPle1ukpBEeQwlZOYto9xy4ATd
         8jTZ5KbajYSifVbIbmsKlcBeDvSgPI/dFKN38mEqDjt4LyeVg6xPThyCiWzBnvK8UQ/q
         SQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccD2JrUqoo8dGTQE9lIA6Ic8NF4n65yiBkZdSFL8aqk=;
        b=0I7bYDmsEFconE9D4LRn+sLcopCEHe8wfHLs69ZbFoGp7SXRqBEKxDS/C+aG+Pcv1j
         j60YDegJnXWiAaurLD+6yalLVdSfVU6FSnbffXEBBTXL61o+yrgQmHCa9SjxLGumw0OI
         s0u1Pt8KSG9v3ZTGBIu4nLko9Q+qzJ/ZLlQramzSCls+V6SS8D2NbuW1c8CxnKV+jfO8
         BXr6+Ays/SRzXfoHmQoYglgEYN1/aAcaBpoJ+S3q0Uyk/hIaIgcCSiQhUSOsdYf0D6wF
         adBCDxeuTMiDWicbdU43YAcyobzRu5W35mSPSAXLpP6NAbmBD3T7uVTd3ag1tDU72n9T
         oAMw==
X-Gm-Message-State: ANoB5pl6ovdGMIe/hC4k+anOGPw09H1Jun2pV3YTf1ANTDDL0qbuJlgr
        hK345R7ZrMP0Ho+ZynTcypI2FA==
X-Google-Smtp-Source: AA0mqf7wH0C0pDIAs+KLfjhRNQCtQ/GYw24Q7zFEM++AAYMYahqX8fgtbDrgd5iOVZMlUmFCMtte/A==
X-Received: by 2002:a2e:be08:0:b0:277:857:87ab with SMTP id z8-20020a2ebe08000000b00277085787abmr16751284ljq.442.1670041170764;
        Fri, 02 Dec 2022 20:19:30 -0800 (PST)
Received: from smtpclient.apple (77.241.136.54.bredband.3.dk. [77.241.136.54])
        by smtp.gmail.com with ESMTPSA id z8-20020a056512370800b004a91d1b3070sm1243597lfr.308.2022.12.02.20.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 20:19:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Date:   Sat, 3 Dec 2022 07:19:17 +0300
Message-Id: <4F15C752-AE73-4F10-B5DD-C37353782111@javigon.com>
References: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, djwong@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com
In-Reply-To: <Y4oSiPH0ENFktioQ@kbusch-mbp.dhcp.thefacebook.com>
To:     Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (20B82)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 2 Dec 2022, at 17.58, Keith Busch <kbusch@kernel.org> wrote:
>=20
> =EF=BB=BFOn Fri, Dec 02, 2022 at 08:16:30AM +0100, Hannes Reinecke wrote:
>>> On 12/1/22 20:39, Matthew Wilcox wrote:
>>> On Thu, Dec 01, 2022 at 06:12:46PM +0000, Chaitanya Kulkarni wrote:
>>>> So nobody can get away with a lie.
>>>=20
>>> And yet devices do exist which lie.  I'm not surprised that vendors
>>> vehemently claim that they don't, or "nobody would get away with it".
>>> But, of course, they do.  And there's no way for us to find out if
>>> they're lying!
>>>=20
>> But we'll never be able to figure that out unless we try.
>>=20
>> Once we've tried we will have proof either way.
>=20
> As long as the protocols don't provide proof-of-work, trying this
> doesn't really prove anything with respect to this concern.

Is this something we should bring to NVMe? Seems like the main disagreement c=
an be addressed there.=20

I will check internally if there is any existing proof-of-work that we are m=
issing.=20=
