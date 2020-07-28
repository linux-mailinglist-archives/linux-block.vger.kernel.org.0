Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1523128D
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 21:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgG1T3N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 15:29:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58776 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgG1T3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 15:29:12 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 50049BF5E6;
        Tue, 28 Jul 2020 19:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1595963977;
        bh=9tVlnBJ6nVvlRvBQ7TSVZs717h5xQKXmoiJilY66jdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thHGVWz5bUhMXq9CGpzIS+1uoDASWJ45B/ykcFBhWG8XunMaeeqhu9gXRh1Ti3gtJ
         u24dJp/lQA34/NecJH5MfCHRgRLjZv4TfTwRhiMPZyOFOc9a1Qbr5rX9VLIVB/fHdD
         DlqOGH93ft/NXen6dfZlC0rxIjDtoBnSajdaDM1L85fVW5OC/NRCXa3K4jfreJE8gj
         yhj9NX2bTwWESlKuA5EK6ovqkk7QxcISxKrp5MgjOGcaLXcHDDha7S2BvTFF5y6ZEu
         6b+HJ9TDJmapLeAd+yiTYwtYJHuDqwS3Emj5GCE09EF0DS0caBnRR91x4kv6I4yNxP
         +/oja2bP/qXbw==
Date:   Tue, 28 Jul 2020 21:19:32 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 1/5] zbd/rc: Support zone capacity report by
 blkzone
Message-ID: <20200728191932.GA103177@apples.localdomain>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728101452.19309-2-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28 19:14, Shin'ichiro Kawasaki wrote:
> Linux kernel 5.9 zone descriptor interface added the new zone capacity
> field defining the range of sectors usable within a zone. The blkzone
> tool recently supported the zone capacity in its report zone feature.
> Modify the helper function _get_blkzone_report() to support the zone
> capacity field.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
