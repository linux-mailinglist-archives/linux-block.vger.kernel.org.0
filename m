Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDD7C64F6
	for <lists+linux-block@lfdr.de>; Thu, 12 Oct 2023 07:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjJLF4z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Oct 2023 01:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJLF4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 01:56:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CAAA9
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 22:56:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BCD061F74D;
        Thu, 12 Oct 2023 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697090210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zyd6H6C6ex+zTMoywWr6vVS5u5kpvCutfphwUa6moD8=;
        b=jJCuQDTY8DM3+eTGYEDalq9w/Q4jbrnMK/8bzA5vDdMKmoDkWWypd/1QY3FfloYAoDbbhW
        Bij6dJ/xPPA/a+5N5/p6EEx5fq2BGNWYHjiuw2CCV6/Bo1dXBcRGHaWS7SRoPtCkgFB84v
        hBZrMFs8XBS8hXEz8xmuxj4L71NWgQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697090210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zyd6H6C6ex+zTMoywWr6vVS5u5kpvCutfphwUa6moD8=;
        b=bRPNkSOtKyJz229zVbAfVGb2szVQz7WoCxTMpqVBk+xoZYnzVyr+dN9eMaeJFefQsdzs6Z
        wLgLc54Kibt0Z3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACBDC139F9;
        Thu, 12 Oct 2023 05:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p4gjKqKKJ2XefwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 12 Oct 2023 05:56:50 +0000
Date:   Thu, 12 Oct 2023 07:58:02 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] block/002: fix TMPDIR path
Message-ID: <75jhknqc3zc4fa7sjtwvn6lba7nqretet7h5ruq2rysq27k2dq@74rjumyjluzx>
References: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
 <20231012021152.832553-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012021152.832553-3-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 12, 2023 at 11:11:52AM +0900, Shin'ichiro Kawasaki wrote:
> There has been a typo of TMPDIR variable. This resulted in blktrace
> files created at unexpected place. Fix the typo.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
