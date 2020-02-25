Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2803C16F26A
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2020 23:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgBYWCz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Feb 2020 17:02:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgBYWCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 17:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vGq7ZCZaBssfGt/pka5y8wzj+d2jM2RozbSKjDU5wNk=; b=o9b4JCyvNPkhK4ll7IS5Zs/PXP
        p7YBNvjJrfb2ZT0blmKPpYOMhB4yygNW2XvEBCg/weQKfPg+bgyamOG767XTe3XxLdXTqUN7E7HJf
        Nv/qGWoENV+6XO2qmonf8+JBBB0OZungOyaG+emu6OlddQT5WF7xhVvuQU61gETDCvT9zNS/sQXhX
        JyEVsldSb+nFc3ggRYLHmG0bCZzATgkiJQVokVFw0R+2gnYzuYGxyfMlzKJ+o9s8+GFZ3mbjdYqB1
        WpyfIglpgn7gHThbgBLYeHQeU6MQbcRmcLArOD0dE0WZ0uv9Z7G5Z2Tq9v4FfS0b88SUuGR9nkoZ6
        ekXuthmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6iI2-0005zL-LO; Tue, 25 Feb 2020 22:02:54 +0000
Date:   Tue, 25 Feb 2020 14:02:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [dm-devel] [PATCH] dm integrity: reinitialize __bi_remaining
 when reusing bio
Message-ID: <20200225220254.GA13356@infradead.org>
References: <20200225170744.10485-1-dg@emlix.com>
 <20200225191222.GA3908@infradead.org>
 <a932a297-266e-4dee-f030-40ecbc9899ca@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a932a297-266e-4dee-f030-40ecbc9899ca@emlix.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 25, 2020 at 08:54:07PM +0100, Daniel Gl�ckner wrote:
> bio_reset will reset too many fields. As you can see in the context of
> the diff, dm-integrity expects f.ex. the values modified by bio_advance
> to stay intact and the transfer should of course use the same disk and
> operation.
> 
> How about doing the atomic_set in bio_remaining_done (in block/bio.c)
> where the BIO_CHAIN flag is cleared once __bi_remaining hits zero?
> Or is requeuing a bio without bio_reset really a no-go? In that case a
> one-liner won't do...

That tends to add a overhead to the fast path for a rather exotic
case.  I'm having a bit of a hard time understanding the dm-integrity
code due to it's annoyingly obsfucated code, but it seems like it
tries to submit a bio again after it came out of a ->end_io handler.
That might have some other problems, but if we only want to paper
over the remaining count a isngle call to bio_inc_remaining might be all
you need.
