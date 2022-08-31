Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEC5A7DFC
	for <lists+linux-block@lfdr.de>; Wed, 31 Aug 2022 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiHaMwF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 Aug 2022 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiHaMwE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 08:52:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADFCBD290
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 05:51:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6200B1F85D;
        Wed, 31 Aug 2022 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661950306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IqM+4SQPR7nVfbzxj8UTCDw4CLSLOrY+hJ8pMgqH/U=;
        b=o9YXpWSQzSitCtVMwtFhEDjLLA5zqUB0NjKYMpF1sdWUN2Do5lhXaedVC53aQhIidjWXzZ
        T9YCSsuKSJe7JyiTAUaG4derptCl0ZipobfoVECHr9hdlR6AQAUcNQJBnxOWD/+0PUMgBU
        kUaADkk9RjskzMROMz9551CednRfugY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661950306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9IqM+4SQPR7nVfbzxj8UTCDw4CLSLOrY+hJ8pMgqH/U=;
        b=d6I1ucrVEi++z0lIyBFPVzciXIemYtoxmLpWKoMyz+hn/l0QsJP3AENK8TWJ2o3UOm0Vx3
        G8n4BS8RnKD6UCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5317913A7C;
        Wed, 31 Aug 2022 12:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +bERFGJZD2O9JgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 31 Aug 2022 12:51:46 +0000
Date:   Wed, 31 Aug 2022 14:51:45 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v1] nvme/045: test queue count changes on
 reconnect
Message-ID: <20220831125145.elxjdc22dmlex4dt@carbon.lan>
References: <20220831120900.13129-1-dwagner@suse.de>
 <a135eef8-ee5a-fdc9-c8c3-f591b3fa0d2e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a135eef8-ee5a-fdc9-c8c3-f591b3fa0d2e@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 31, 2022 at 12:44:20PM +0000, Chaitanya Kulkarni wrote:
> On 8/31/22 05:09, Daniel Wagner wrote:
> > The target is allowed to change the number of I/O queues. Test if the
> > host is able to reconnect in this scenario.
> > 
> > This test depends that the target supporting setting the amount of I/O
> > queues via attr_qid_max configfs file. If this not the case, the test
> > will always pass. Unfortunatly, we can't test if the file exist before
> > creating a subsystem.
> 
> Perhaps create a subsystem and skip the test instead of passing with
> right skip reason since it creates  ?

I was not sure if it's worth to create a dummy subsystem just to test if
we have the feature. Thinking about it, my version could lead to false
positives which is also bad.

> OR that is too complicated to implement in the test ?

Don't think so. But I might go ahead and create a generic 'does attr'
exist function.
