Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5EC51761D
	for <lists+linux-block@lfdr.de>; Mon,  2 May 2022 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiEBRtk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 May 2022 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386753AbiEBRth (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 13:49:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6C9FD1
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 10:46:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 541331F42E61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651513561;
        bh=fSHWdWLfrNdMmU+qnTaxgSee/TwthYC5RsccC8c/o9o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RKklCiOhLr9GOf0sAoUJU/SM3lVSR7+kSSb4jZiX2Zo5LYcY8Kt3vOPFNDI/tTvtx
         5+Ehn56ASPO7aHGFEkBw6HNt/kjuvnfJYBeF1xRGxHOCb2XJh9S0O13zUHyMdK+MgH
         6Fcy+P+6acIb6Yr8i6rQTtSgfXjaZ2RT/SQp9LG79EEi4E5W6uuLqU375IwFWOIk0L
         rci78xSiZHPitWL/RbpoaecO7LMdXFAxYL7Apky1PREr9cfx1OzvzcPi/2XfxdnnaH
         2cick2a/18ozLgSJ61IiQcY/Dc7rFkvMS+BruV3j9rAyOkx2z0QBjbF5kxB/HrOzt3
         GjL6O2p88xgtA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Khazhismel Kumykov" <khazhy@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
Organization: Collabora
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
Date:   Mon, 02 May 2022 13:45:55 -0400
In-Reply-To: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de> (Hannes Reinecke's
        message of "Mon, 2 May 2022 09:21:31 -0700")
Message-ID: <87y1zjq14c.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> Hi Omar,
>
> and another topic which came up during discussion yesterday:
>
> eBPF for block devices
> It would be useful to enable eBPF for block devices, such that we could
> do things like filtering bios on bio type, do error injection by 
> modifying the bio result etc.
> This topic should be around how it could be implemented and what
> additional use-cases could be supported.

Cc'ing Khazhy since Google might have some applications for this to
filter IOs based on the blocks being accessed, in the context of
safeguarding specific regions from accidental overwrites / application
error.

-- 
Gabriel Krisman Bertazi
