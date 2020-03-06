Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5217C1CA
	for <lists+linux-block@lfdr.de>; Fri,  6 Mar 2020 16:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgCFP3c (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Mar 2020 10:29:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36790 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgCFP3b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Mar 2020 10:29:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id u25so2661060qkk.3
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2020 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PbvQp0mcFJZRWUllfmz/rnyregscayhvYgNCNOwQuE0=;
        b=VwS4+eK1QrC1jlaCH8Vi8peEQ4BnOpLpGX9oNqzVLxIc9ewD3vXR6VVYIPuxFLXpIc
         2c3xuas2S7wbkctyBKbOljO4VhdF7/jbqKKjoBUucc5+G0eU1BhTkfUhr04OY6yTz9dM
         Y4LQxMvGWP8dqttZ1UF646uiuNLrc8tPy69mJ4mD890sMQAZ6+E3e81c16oSh8HG2/ym
         Z644E2xP359Wms/WlKH+uISKE6MviGUEwZpk8ivXjWPoou2ehCkGgzSxnCmeF6m0/L52
         /lmWJuqxtUClZIYuTLFuvVeQCcezokCuINwMAnA/ddlyftMV2Qa9wSVmej4cL4VZCX6l
         sU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PbvQp0mcFJZRWUllfmz/rnyregscayhvYgNCNOwQuE0=;
        b=gB3PNjlBRo6quh/VMnAl3FVxB8NVpFl+gIBaZjkDSfY2Ic2yJp0wPJ4qEP4s1Qtx7B
         pN/TnWwW2HctnkepmsLeLlQMsRRkPgg1TDB6aRmFASGbMAc6FXbqeU0kMCLwil0+pn67
         GZaBpiHnyBWH+sOE4p2+pY16DmMpk7k+1Mn2TGu05TDlA+o1tmAY6o4YFOuCf6m0G+OH
         f9hJAQqxqsrRqd6P03bHiMktjmYXC3A0uMsIjUueEcpbV/wmNRRSPK5rZYm+MqBTCoOz
         5bGqzjrd2lXn4/68fDQhV2Pd+z9/TfDaa1sh+Npbi83l1FjZ7IA6ZYDB1LiYPluMw6mq
         +yVw==
X-Gm-Message-State: ANhLgQ1Vjo1mSzq0wkjVJoiuCIi1DSHoYRZQ36l3e5hvXVplq29H8hUT
        NxDTO9ocA8IFPxWaksHlhEHQJA==
X-Google-Smtp-Source: ADFU+vvZz4swHN8hgN+Sb7HSKQietOBMfwnEFzAXiiNITZAjmI/a+uSsA239li41AE2+e0r2LZJNkQ==
X-Received: by 2002:a05:620a:16d4:: with SMTP id a20mr3558798qkn.168.1583508569931;
        Fri, 06 Mar 2020 07:29:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d35sm16733291qtc.21.2020.03.06.07.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 07:29:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jAEum-0004LB-Bj; Fri, 06 Mar 2020 11:29:28 -0400
Date:   Fri, 6 Mar 2020 11:29:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306152928.GL31668@ziepe.ca>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 06, 2020 at 09:35:41AM -0500, Josef Bacik wrote:

> 1) The invitation process.  This goes away.  The people/companies that want
> to discuss things with the rest of us can all get to plumbers the normal
> way.  We get new blood that we may miss through the invitation process
> because they can simply register for Plumbers on their own.

At last year at plumbers there were many people who could not get
tickets, it has been full the last few years, I think.

IMHO LPC is about at the size now where it is almost as large as it
can be in a mid-sized hotel setting..

> 4) Planning becomes much simpler.  I've organized miniconf's at plumbers
> before, it is far simpler than LSFMMBPF.  You only have to worry about one
> thing, is this presentation useful.  I no longer have to worry about am I
> inviting the right people, do we have enough money to cover the space.  Is
> there enough space for everybody?  Etc.

LPC does a great job at making miniconfs 'easy' - really fantastic
actually. I really appreciate how great a job they do on getting video
out and trying hard to mic everything so the freewheeling discussions
are audible to everyone.

Maybe something to think about is to keep the LSFMMBPF time slot but
instead of building a conference from scratch, copy LPC - same venue,
contracts, format, etc, etc. Ie two LPC style conferences a year, but
without having to plan two completely different sites from scratch.

IIRC when LPC was in Vancouver the LF used the same venue for several
conferences, I wonder how that worked out?

Jason
