Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B83CD159
	for <lists+linux-block@lfdr.de>; Mon, 19 Jul 2021 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhGSJRJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Jul 2021 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhGSJRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:17:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9491C061574;
        Mon, 19 Jul 2021 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DONrBKe0eDHZgnOVXg2rUrja0fq1NqKtT/Q/VwbF93s=; b=qvj01gb4dGHw/A51PUG4ACE0Dw
        Seb+BDqozPlbJP6oroIE/M5gylWf+xTaGkhki3+dYbK9iCZd1E+bCNJhYTi9s6SPAosAZr/MUHf1Z
        SIfy+bcZdFEvop5sRGMmRUIueNZW0yD8ycdCFJqaWAg+T+acxHF08F3TyNndAjfBQa+AJI6KOmfYo
        IbRKbu/OmIO0NlIfDFfaOhxVwsszRX4mV+MmRVwl6YJSa3gr01GEN6ByeGRAwXXh0P9CDGbbOPZvj
        M6kQ8rSgFBReWXzGZHvVGASaynm2MR/sRm+VYD6zbjAxZQuWMBaypT8/kEMj7zRr/fSMo/GFy24IE
        fHxG/rCw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Q0N-006ipf-5F; Mon, 19 Jul 2021 09:56:31 +0000
Date:   Mon, 19 Jul 2021 10:56:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] block: enhance use of GENHD_FL_UP
Message-ID: <YPVMN90+tyKHTC7V@infradead.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So while patch 1 seems a little pointless given where I'd like to go,
the rest of the series goes exactly where I'd like to move things.
Can you respin this one quickly and send it out to Jens without the RFC?
