Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8347EA358D
	for <lists+linux-block@lfdr.de>; Fri, 30 Aug 2019 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3LST (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 30 Aug 2019 07:18:19 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:13974 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfH3LSS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 07:18:18 -0400
X-Greylist: delayed 1851 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 07:18:17 EDT
Received: from [81.153.82.187] (helo=[192.168.1.118])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1i3eRB-0000pe-3q; Fri, 30 Aug 2019 11:47:25 +0100
Subject: Re: [PATCH v3 1/2] md raid0/linear: Mark array as 'broken' and fail
 BIOs if a member is gone
To:     Song Liu <songliubraving@fb.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
References: <20190822161318.26236-1-gpiccoli@canonical.com>
 <73C4747E-7A9E-4833-8393-B6A06C935DBE@fb.com>
 <8163258e-839c-e0b8-fc4b-74c94c9dae1d@canonical.com>
 <F0E716F8-76EC-4315-933D-A547B52F1D27@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.com>
From:   Wols Lists <antlists@youngman.org.uk>
Message-ID: <5D68FEBC.9060709@youngman.org.uk>
Date:   Fri, 30 Aug 2019 11:47:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <F0E716F8-76EC-4315-933D-A547B52F1D27@fb.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/08/19 18:51, Song Liu wrote:
> I guess md_is_broken() should return bool? Otherwise, looks good to me. 

Just an outsider's observation - if the function is actually checking
whether a member is missing maybe it should read

   broken = md_member_is_missing();

That way the function says what it does, and the assignment says what
you're doing with it.

Cheers,
Wol
