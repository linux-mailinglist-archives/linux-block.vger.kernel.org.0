Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B69179899
	for <lists+linux-block@lfdr.de>; Wed,  4 Mar 2020 20:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgCDTHO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Mar 2020 14:07:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43268 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDTHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 14:07:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id e3so3252196lja.10
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYT2b2+02PZsG7YNDjTHObfopfKwl69vuluqo48GtJw=;
        b=QJJaTlfxPTMoTxtK1XHZvXMFVGBnLffTe/+9mW/Qd9Il6OJypyzc21xa0zz640aZI5
         aOv6F+hJLv5Owrw2fuIVJCVO3DTfhN6J+w6UVDiwa/E1sfGrTYLirbmFM4qfA9Pn//Qv
         2Dl6vmlTskaRT3KY2m7kovKHFDfPwOAJCMGVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYT2b2+02PZsG7YNDjTHObfopfKwl69vuluqo48GtJw=;
        b=rg3IKRqRJ09Ry/iaTjL35s04G3xOShi8jtn0HH3nfNBitc+yWOROtYCgiU4jdrLJ6n
         2D6q97NyBWKwi7mDjwBLQEXLNVLhTicQj7DQgcwV6J+tGdQNBJH3I2EyF7lMQD0n34hC
         rPWhzVjY2u8AOErql+/0Mz/GUlzqOLMFqpHAMTg2LGlQxSjePUe4iEVZD2oUugapdcR6
         G8qcdmxAeQT5DeTpzHAl552FbBRg30av+JhTj6+M2dlVCKpXfQDwPJzN2sKV8BUGXF5Y
         Moo5c4LmJ34V1bmFLJgC7G/n5uKVxiXJatRJTbn0EXiMe9w2wYqxxMVkqMeux/LH4seu
         D4WQ==
X-Gm-Message-State: ANhLgQ31nXATxN6kIyIf/rKyNsvtfmbawQ1Wu2XM1n3xy6nPQPSSUz9T
        z4HeYEUGI7cUzBD2rOSOcoewz8rUUdEYEw==
X-Google-Smtp-Source: ADFU+vuGeJGwqA2qDrGpycBN05KOrrwZB++N6uk1RguSMuqXzgz1mzEnR8Iy4Fbwi4VSWMfkCJoQvg==
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr2838191ljp.222.1583348832326;
        Wed, 04 Mar 2020 11:07:12 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id n22sm5380132lfe.72.2020.03.04.11.07.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:07:11 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id z9so2450913lfa.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 11:07:11 -0800 (PST)
X-Received: by 2002:a19:6406:: with SMTP id y6mr2912296lfb.125.1583348831107;
 Wed, 04 Mar 2020 11:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20200304150257.GA19885@redhat.com>
In-Reply-To: <20200304150257.GA19885@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Mar 2020 13:06:55 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgP=q648JXn8Hd9q7DuNaOEpLmxQp2W3RO3vkaD2CS_9g@mail.gmail.com>
Message-ID: <CAHk-=wgP=q648JXn8Hd9q7DuNaOEpLmxQp2W3RO3vkaD2CS_9g@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 5.6-rc5
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 4, 2020 at 9:03 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> - Bump the minor version for DM core and all target versions that have
>   seen interface changes or important fixes during the 5.6 cycle.

Can we please remove these pointless version markers entirely?

They make no sense. The kernel doesn't allow backwards incompatible
changes anyway, so the whole point of using some kind of interface
versioning is entirely bogus.

The way you test if a new feature exists or not is to just use it, and
if you're running on an old kernel that doesn't support that
operation, then it should return an error.

             Linus
